#include "../include/LoopUnswitchPass.h"
#include "../include/Cand.h"

using namespace llvm;
//using namespace llvm::PatternMatch;

namespace 
{
    // Хранение результатов работы оптимизации
    struct 
    UnswitchResult 
    {
        SmallVector<Loop*, 8> NewLoops; // Новые петли, созданные в процессе оптимизации
        bool Changed = false; // Флаг изменения в исходной петле
    };

    //Определение параметра порога стоимости через терминал
    static cl::opt<unsigned>
    ClIppThreshold( "loop-unswitch-threshold", cl::init(0), cl::Hidden,
        cl::desc("Override cost threshold for IPP unswitch (0 = keep pass option)") );

    // Грубая оценка стоимости дублирования
    static unsigned 
    estimateDupCost( const Loop &L ) 
    {
        unsigned Cost = 0;
        for (BasicBlock *BB : L.blocks())
        {
            for (Instruction &I : *BB)
            {
                if (!I.isTerminator())
                    ++Cost;
            }
        }

        return Cost;
    }

    // Проверки безопасности для выполнения операции.
    static bool 
    basicSafetyChecks( Loop &L, LoopStandardAnalysisResults &AR ) 
    {
        if (!L.getLoopPreheader()) 
            return false;
        
        if (!L.isLoopSimplifyForm()) 
            return false;

        if (!L.isLCSSAForm(AR.DT))
            return false;

        return true;
    }

    // Проверка инвариантности условия
    static bool 
    isInvariantSelector( Value *Sel, Loop &L, LoopStandardAnalysisResults &AR ) 
    {
        if (!Sel || !Sel->getType()->isIntegerTy()) 
            return false;

        if (!L.isLoopInvariant(Sel)) 
            return false;

        if (auto *I = dyn_cast<Instruction>(Sel)) 
        {
            BasicBlock *PH = L.getLoopPreheader();
            if (!PH) 
                return false;
        
            if (!AR.DT.dominates(I, PH->getTerminator()) && !isSafeToSpeculativelyExecute(I))
                    return false;
        }

        return true;
    }

    // Попытка выбрать кандидатную ветку
    static std::optional<Cand> 
    pickCandidate( Loop &L, LoopStandardAnalysisResults &AR ) 
    {
        if (auto *HTerm = L.getHeader()->getTerminator()) 
        {
            if (auto *HS = dyn_cast<SwitchInst>(HTerm)) 
            {
                if (isInvariantSelector(HS->getCondition(), L, AR))
                    return Cand{Cand::Sw, nullptr, HS, HS->getCondition()};
            }
            if (auto *HB = dyn_cast<BranchInst>(HTerm)) 
            {
                if (HB->isConditional() && HB->getCondition()->getType()->isIntegerTy(1))
                {
                    if (isInvariantSelector(HB->getCondition(), L, AR))
                        return Cand{Cand::CondBr, HB, nullptr, HB->getCondition()};
                }
            }
        }
        
        //для switch
        for (BasicBlock *BB : L.blocks()) 
        {
            if (auto *SI = dyn_cast<SwitchInst>(BB->getTerminator())) 
            {
                Value *C = SI->getCondition();
                if (isa<ConstantInt>(C) || SI->getNumCases() == 0) 
                    continue;

                if (!isInvariantSelector(C, L, AR)) 
                    continue;

                return Cand{Cand::Sw, nullptr, SI, C};
            }
        }
            
        //для if/else
        for (BasicBlock *BB : L.blocks()) 
        {
            if (auto *BI = dyn_cast<BranchInst>(BB->getTerminator())) 
            {
                if (!BI->isConditional()) 
                    continue;
                Value *Cond = BI->getCondition();
                if (Cond->getType()->isIntegerTy(1) && isInvariantSelector(Cond, L, AR)) 
                    return Cand{Cand::CondBr, BI, nullptr, BI->getCondition()};
            }
        }

        return std::nullopt;
    }

    // Исправление PHI-узлов в выходных блоках после клонирования
    static void 
    fixExitPHIsForClone( const Loop &L, ValueToValueMapTy &VMap ) 
    {
        SmallVector<BasicBlock*, 8> ExitBlocks;
        L.getExitBlocks(ExitBlocks);
        for (BasicBlock *Exit : ExitBlocks) 
        {
            for (PHINode &PN : Exit->phis()) 
            {
                for (unsigned i = 0; i < PN.getNumIncomingValues(); ++i) {
                    BasicBlock *Pred = PN.getIncomingBlock(i);
                    if (!L.contains(Pred)) 
                        continue;
                    
                    Value *V = PN.getIncomingValue(i);
                    auto *ClonePred = cast_or_null<BasicBlock>(VMap.lookup(Pred));
                    if (!ClonePred) 
                        continue;

                    Value *Mapped = VMap.lookup(V);
                    if (!Mapped) 
                        Mapped = V;

                    PN.addIncoming(Mapped, ClonePred);
                }
            }
        }
    }

    // Замена всех использований условия внутри циклана заданню константу (С)
    static void 
    rewriteCondInsideLoop( Loop &L, Value *Cond, ConstantInt *C ) 
    {
        SmallVector<Instruction*, 64> Work;
        for (BasicBlock *BB : L.blocks())
        {
            for (Instruction &I : *BB)
            {
                Work.push_back(&I);
            }
        }

        for (Instruction *I : Work)
        {
            I->replaceUsesOfWith(Cond, C);
        }
    }

    // Свёртка терминаторов
    static void 
    foldTerminators(ArrayRef<BasicBlock*> Blocks ) 
    {
        for (BasicBlock *BB : Blocks) 
        {
            ConstantFoldTerminator(BB, true, nullptr, nullptr);
            SimplifyInstructionsInBlock(BB);
        }
    }

    // Замена в switch условного перехода, соответствующее селектору, на безусловное
    static void 
    forceSwitchToDefault( Loop &L, Value *Sel ) 
    {
        SmallVector<SwitchInst*, 8> ToFix;
        for (BasicBlock *BB : L.blocks())
        {
            if (auto *SI = dyn_cast<SwitchInst>(BB->getTerminator()))
            {
                if (SI->getCondition() == Sel)
                    ToFix.push_back(SI);
            }
        }
            
        for (SwitchInst *SI : ToFix) 
        {
            BasicBlock *Def = SI->getDefaultDest();
            ReplaceInstWithInst(SI, BranchInst::Create(Def));
        }
    }

} //namespace

namespace LoopPass
{
    PreservedAnalyses 
    LoopUnswitchPass::run(Loop &L0, LoopAnalysisManager &,
        LoopStandardAnalysisResults &AR, LPMUpdater &U) 
    {
        // Получение порога для оптимизации                
        auto getThreshold = [&](void) 
        {
            unsigned Th = Cfg.Threshold;
            if (ClIppThreshold.getNumOccurrences() > 0) Th = ClIppThreshold.getValue();
            return Th;
        };

        // Подготовка контекста
        Function *F = L0.getHeader()->getParent();
        LLVMContext &Ctx = F->getContext();
        FunctionCallee AssumeC = Intrinsic::getOrInsertDeclaration(F->getParent(), Intrinsic::assume);

        // Обработка петель
        SmallVector<Loop*, 16> Worklist;
        Worklist.push_back(&L0);
        bool Changed = false;
        while (!Worklist.empty()) 
        {
            Loop *L = Worklist.pop_back_val();
            if (!L || !L->getHeader()) 
                continue;

            if (!basicSafetyChecks(*L, AR)) 
                continue;

            // Обработка циклов
            bool LocalProgress = false;
            while (true) 
            {
                unsigned Est = estimateDupCost(*L);
                unsigned Th  = getThreshold();
                if (Th && Est > Th) 
                    break;

                // Выборка кандидата для оптимизации
                auto CandOpt = pickCandidate(*L, AR);
                if (!CandOpt) 
                    break;

                Cand C = *CandOpt;

                // Оценка целесообразности выноса инвариантного условия, если рассматриваем switch
                if (C.K == Cand::Sw) {
                    unsigned K = C.SI->getNumCases();
                    if (K == 0) 
                        break;

                    if (Th && Est * K > Th) 
                        break;
                }

                BasicBlock *Preheader = L->getLoopPreheader();
                BasicBlock *Header    = L->getHeader();
                if (!Preheader || !Header) break;

                // Обработка if/else
                if (C.K == Cand::CondBr) 
                {
                    Value *Sel = C.Sel;

                    // Гварды у прехедера
                    auto *PHTrue  = BasicBlock::Create(Ctx, "ipp.unsw.ph.true",  F, Header);
                    auto *PHFalse = BasicBlock::Create(Ctx, "ipp.unsw.ph.false", F, Header);
                    ReplaceInstWithInst(Preheader->getTerminator(), BranchInst::Create(PHTrue, PHFalse, Sel));

                    // Клонирование петли под Sel=true
                    SmallVector<BasicBlock*, 32> ClonedBlocks;
                    ValueToValueMapTy VMap;
                    VMap[Sel] = ConstantInt::getTrue(Ctx);

                    for (BasicBlock *BB : L->blocks()) 
                    {
                        auto *Clone = CloneBasicBlock(BB, VMap, ".ipp", F);
                        Clone->moveBefore(Header);
                        VMap[BB] = Clone;
                        ClonedBlocks.push_back(Clone);
                    }

                    for (auto *CB : ClonedBlocks)
                    {
                        for (Instruction &I : *CB)
                        RemapInstruction(&I, VMap, RF_NoModuleLevelChanges | RF_IgnoreMissingLocals);
                    }

                    auto *ClonedHeader = cast<BasicBlock>(VMap.lookup(Header));

                    // PHTrue - клон
                    IRBuilder<> BT(PHTrue);  
                    BT.CreateCall(AssumeC, Sel);                 
                    BT.CreateBr(ClonedHeader); 
                    
                    // PHFalse - оригинал
                    IRBuilder<> BF(PHFalse); 
                    Value *Not = BF.CreateNot(Sel); 
                    BF.CreateCall(AssumeC, Not); 
                    BF.CreateBr(Header); 

                    // Починка PHI заголовков
                    for (PHINode &PN : Header->phis())
                    {
                        for (unsigned i = 0; i < PN.getNumIncomingValues(); ++i)
                        {
                            if (PN.getIncomingBlock(i) == Preheader) 
                                PN.setIncomingBlock(i, PHFalse);
                        }
                    }
                    
                    for (PHINode &PN : ClonedHeader->phis())
                    {
                        for (unsigned i = 0; i < PN.getNumIncomingValues(); ++i)
                        {
                            if (PN.getIncomingBlock(i) == Preheader) 
                                PN.setIncomingBlock(i, PHTrue);
                        }
                    }

                    rewriteCondInsideLoop(*L, Sel, ConstantInt::getFalse(Ctx));

                    // LCSSA-фиксы на выходах и локальные свёртки
                    fixExitPHIsForClone(*L, VMap);
                    SmallVector<BasicBlock*, 32> OrigBlocks(L->blocks().begin(), L->blocks().end());
                    foldTerminators(OrigBlocks);
                    foldTerminators(ClonedBlocks);
                    removeUnreachableBlocks(*F);

                    for (BasicBlock &BB : *F)
                    {
                        for (auto It = BB.begin(); It != BB.end(); ) 
                        {
                            Instruction *I = &*It++;
                            if (isInstructionTriviallyDead(I)) 
                                I->eraseFromParent();
                        }
                    }
                    

                    // Пересбор анализов, собираем новые петли
                    AR.DT.recalculate(*F);
                    AR.LI.releaseMemory();
                    AR.LI.analyze(AR.DT);

                    SmallVector<Loop*, 4> NewLoops;
                    if (auto *LC = AR.LI.getLoopFor(ClonedHeader)) 
                        NewLoops.push_back(LC);
                
                    if (auto *Lorig = AR.LI.getLoopFor(Header))     
                        NewLoops.push_back(Lorig);

                    for (Loop *NL : NewLoops) 
                    {
                        simplifyLoop(NL, &AR.DT, &AR.LI, &AR.SE, &AR.AC, nullptr, false);
                        formLCSSA(*NL, AR.DT, &AR.LI, &AR.SE);
                    }

                    if (!NewLoops.empty()) 
                    {
                        Worklist.append(NewLoops.begin(), NewLoops.end());
                        U.addSiblingLoops(NewLoops);
                    }

                    Changed = LocalProgress = true;
                    break; 
                }

                // Обработка switch
                else if (C.K == Cand::Sw) 
                {
                    Value *Sel = C.Sel;
                    auto  *SI  = C.SI;

                    BasicBlock *GuardCur = Preheader;
                    SmallVector<BasicBlock*, 8> ClonedHeaders;

                    // Гварды
                    for (auto &Case : SI->cases()) 
                    {
                        ConstantInt *Ci = Case.getCaseValue();
                        auto *PHCase    = BasicBlock::Create(Ctx, "ipp.sw.ph.case",    F, Header);
                        auto *NextGuard = BasicBlock::Create(Ctx, "ipp.sw.guard.cont", F, Header);

                        if (Instruction *OldT = GuardCur->getTerminator()) 
                            OldT->eraseFromParent();
                        
                        IRBuilder<> GB(GuardCur);
                        Value *Eq = GB.CreateICmpEQ(Sel, Ci);
                        GB.CreateCondBr(Eq, PHCase, NextGuard);

                        IRBuilder<> PC(PHCase);
                        PC.CreateCall(AssumeC, Eq);

                        // Клон петли под Sel==Ci
                        SmallVector<BasicBlock*, 32> ClonedBlocks;
                        ValueToValueMapTy VMapCase;
                        VMapCase[Sel] = Ci;

                        for (BasicBlock *BB : L->blocks()) 
                        {
                            auto *Clone = CloneBasicBlock(BB, VMapCase, ".sw", F);
                            Clone->moveBefore(Header);
                            VMapCase[BB] = Clone;
                            ClonedBlocks.push_back(Clone);
                        }

                        for (auto *CB : ClonedBlocks)
                        {
                            for (Instruction &I : *CB)
                            {
                                RemapInstruction(&I, VMapCase, RF_NoModuleLevelChanges | RF_IgnoreMissingLocals);
                            }
                        }
                            
                        auto *ClonedHeader = cast<BasicBlock>(VMapCase.lookup(Header));
                        ClonedHeaders.push_back(ClonedHeader);

                        for (PHINode &PN : ClonedHeader->phis())
                        {
                            for (unsigned i = 0; i < PN.getNumIncomingValues(); ++i)
                            {
                                if (PN.getIncomingBlock(i) == Preheader) 
                                    PN.setIncomingBlock(i, PHCase);
                            } 
                        }
                            
                        PC.CreateBr(ClonedHeader);

                        fixExitPHIsForClone(*L, VMapCase);
                        foldTerminators(ClonedBlocks);

                        GuardCur = NextGuard;
                    }

                    // default - оригинал
                    auto *PHDef = BasicBlock::Create(Ctx, "ipp.sw.ph.default", F, Header);
                    if (Instruction *OldT = GuardCur->getTerminator()) OldT->eraseFromParent();
                    IRBuilder<>(GuardCur).CreateBr(PHDef);
                    IRBuilder<>(PHDef).CreateBr(Header);

                    for (PHINode &PN : Header->phis())
                    {
                        for (unsigned i = 0; i < PN.getNumIncomingValues(); ++i)
                        {
                            if (PN.getIncomingBlock(i) == Preheader) 
                                PN.setIncomingBlock(i, PHDef);
                        }
                    }
                    
                    // Переход на default
                    forceSwitchToDefault(*L, Sel);

                    // Глобальные свёртки
                    SmallVector<BasicBlock*, 32> OrigBlocks(L->blocks().begin(), L->blocks().end());
                    foldTerminators(OrigBlocks);
                    removeUnreachableBlocks(*F);

                    for (BasicBlock &BB : *F)
                    {
                        for (auto It = BB.begin(); It != BB.end(); ) 
                        {
                            Instruction *I = &*It++;
                            if (isInstructionTriviallyDead(I)) 
                                I->eraseFromParent();
                        }
                    }
                    

                    // Пересбор анализов и новые петли
                    AR.DT.recalculate(*F);
                    AR.LI.releaseMemory();
                    AR.LI.analyze(AR.DT);

                    SmallVector<Loop*, 8> NewLoops;
                    for (BasicBlock *CH : ClonedHeaders)
                    {
                        if (auto *LC = AR.LI.getLoopFor(CH)) 
                            NewLoops.push_back(LC);
                    }
                    
                    if (auto *LDef = AR.LI.getLoopFor(Header)) 
                        NewLoops.push_back(LDef);

                    for (Loop *NL : NewLoops) 
                    {
                        simplifyLoop(NL, &AR.DT, &AR.LI, &AR.SE, &AR.AC, nullptr, false);
                        formLCSSA(*NL, AR.DT, &AR.LI, &AR.SE);
                    }

                    if (!NewLoops.empty()) 
                    {
                        Worklist.append(NewLoops.begin(), NewLoops.end());
                        U.addSiblingLoops(NewLoops);
                    }

                    Changed = LocalProgress = true;
                    break;
                }

                break; 
            } 

            (void)LocalProgress;
        } 

        return Changed ? PreservedAnalyses::none() : PreservedAnalyses::all();
    }

    bool 
    LoopUnswitchPass::isRequired( void )
    {
        return true;
    }
} //namespace LoopPass

