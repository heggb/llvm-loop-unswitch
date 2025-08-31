#ifndef CAND_H
#define CAND_H

#include "llvm/IR/Instructions.h"

// Кандидат на оптимизацию
    struct 
    Cand 
    {
        enum Kind { CondBr, Sw } K;
        llvm::BranchInst *BI = nullptr;
        llvm::SwitchInst *SI = nullptr;
        llvm::Value *Sel = nullptr; //селектор
    };

#endif