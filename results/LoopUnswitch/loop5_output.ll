; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/loop5_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/loop5_input.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @qux(ptr noundef %A, ptr noundef %B, i32 noundef %n, i32 noundef %flag) #0 {
entry:
  %tobool = icmp ne i32 %flag, 0
  br i1 %tobool, label %ipp.unsw.ph.true, label %ipp.unsw.ph.false

ipp.unsw.ph.true:                                 ; preds = %entry
  call void @llvm.assume(i1 %tobool)
  br label %for.cond.ipp

ipp.unsw.ph.false:                                ; preds = %entry
  %0 = xor i1 %tobool, true
  call void @llvm.assume(i1 %0)
  br label %for.cond

for.cond.ipp:                                     ; preds = %ipp.unsw.ph.true, %if.then.ipp
  %i.0.ipp = phi i32 [ 0, %ipp.unsw.ph.true ], [ %inc.ipp, %if.then.ipp ]
  %cmp.ipp = icmp slt i32 %i.0.ipp, %n
  br i1 %cmp.ipp, label %if.then.ipp, label %for.end

if.then.ipp:                                      ; preds = %for.cond.ipp
  %idxprom.ipp = sext i32 %i.0.ipp to i64
  %arrayidx.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom.ipp
  %1 = load float, ptr %arrayidx.ipp, align 4
  %add.ipp = fadd float %1, 1.000000e+00
  %idxprom1.ipp = sext i32 %i.0.ipp to i64
  %arrayidx2.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom1.ipp
  store float %add.ipp, ptr %arrayidx2.ipp, align 4
  %inc.ipp = add nsw i32 %i.0.ipp, 1
  br label %for.cond.ipp, !llvm.loop !6

for.cond:                                         ; preds = %ipp.unsw.ph.false, %if.else
  %i.0 = phi i32 [ 0, %ipp.unsw.ph.false ], [ %inc, %if.else ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %if.else, label %for.end

if.else:                                          ; preds = %for.cond
  %idxprom3 = sext i32 %i.0 to i64
  %arrayidx4 = getelementptr inbounds float, ptr %B, i64 %idxprom3
  %2 = load float, ptr %arrayidx4, align 4
  %sub = fsub float %2, 1.000000e+00
  %idxprom5 = sext i32 %i.0 to i64
  %arrayidx6 = getelementptr inbounds float, ptr %A, i64 %idxprom5
  store float %sub, ptr %arrayidx6, align 4
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.ipp
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 22.0.0git (https://github.com/llvm/llvm-project 03372c7782e60f0c52dea39fbd5f87e19e306967)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
