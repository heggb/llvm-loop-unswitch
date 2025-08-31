#ifndef LOOPUNSWITCHPASS_H
#define LOOPUNSWITCHPASS_H

#include "../include/pch.h"
#include "../include/Config.h"

namespace LoopPass 
{
    struct 
    LoopUnswitchPass : llvm::PassInfoMixin<LoopUnswitchPass>
    {
        Config Cfg;

        LoopUnswitchPass( Config C ) : Cfg(C) {}

        llvm::PreservedAnalyses 
        run( llvm::Loop &L, 
            llvm::LoopAnalysisManager &AM,
            llvm::LoopStandardAnalysisResults &AR,
            llvm::LPMUpdater &U );

        static bool 
        isRequired( void );
    };
} //namespace LoopPass
#endif