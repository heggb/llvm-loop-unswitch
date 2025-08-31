#include "../include/LoopUnswitchPass.h"
//#include "../include/Cand.h"
//#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
//#include "llvm/Analysis/LoopAnalysisManager.h"

using namespace llvm;

namespace 
{
    static bool parseOptions(llvm::StringRef Params, Config &Cfg) 
    {
        if (Params.empty()) 
            return true;

        SmallVector<StringRef, 8> Items;
        Params.split(Items, ';');

        for (StringRef It : Items) 
        {
            It = It.trim();
            if (It.consume_front("threshold=")) 
            {
                unsigned V = 0;
                if (It.getAsInteger(10, V)) 
                    return false;

                Cfg.Threshold = V;
            } 
            else if (It.consume_front("max-versions=")) 
            {
                unsigned V = 0;
                if (It.getAsInteger(10, V)) 
                    return false;

                Cfg.MaxVersions = V;
            } 
            else if (It.equals_insensitive("no-wcet")) 
            {
                Cfg.WcetMode = false;
            } 
            else if (It.equals_insensitive("no-nontrivial")) 
            {
                Cfg.NonTrivial = false;
            } 
            else if (!It.empty()) 
            {
                return false;
            }
        }

        return true;
    }
} //namespace


extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo llvmGetPassPluginInfo() 
{
    return 
    { 
        LLVM_PLUGIN_API_VERSION,    // APIversion
        "LoopUnswitch",             // PluginName
        LLVM_VERSION_STRING,        // PluginVersion
        [](PassBuilder &PB) 
        {
            // Регистрация конвейера для анализа в цикле
            PB.registerPipelineParsingCallback
            (
                [](StringRef Name, LoopPassManager &LPM, ArrayRef<PassBuilder::PipelineElement> Inner) 
                {
                    if (Name.consume_front("loop-unswitch-pass")) 
                    {
                        if (!Inner.empty()) 
                            return false;

                        Config Cfg;
                        if (Name.starts_with("<") && Name.ends_with(">")) 
                        {
                            StringRef Params = Name.drop_front(1).drop_back(1);
                            if (!parseOptions(Params, Cfg)) 
                                return false;
                        }
                        LPM.addPass(LoopPass::LoopUnswitchPass(Cfg));

                        return true;
                    }

                    return false;
                }
            );
        }
    };
}
