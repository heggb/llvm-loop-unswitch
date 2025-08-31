; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/switch2_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/switch2_input.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @foo(ptr noundef %A, i32 noundef %n, i32 noundef %mode) #0 {
entry:
  %0 = icmp eq i32 %mode, 0
  br i1 %0, label %ipp.sw.ph.case, label %ipp.sw.guard.cont

ipp.sw.ph.case:                                   ; preds = %entry
  call void @llvm.assume(i1 %0)
  br label %for.cond.sw

ipp.sw.guard.cont:                                ; preds = %entry
  %1 = icmp eq i32 %mode, 1
  br i1 %1, label %ipp.sw.ph.case1, label %ipp.sw.guard.cont2

for.cond.sw:                                      ; preds = %ipp.sw.ph.case, %for.inc.sw
  %i.0.sw = phi i32 [ 0, %ipp.sw.ph.case ], [ %inc.sw, %for.inc.sw ]
  %cmp.sw = icmp slt i32 %i.0.sw, %n
  br i1 %cmp.sw, label %sw.bb.sw, label %for.end

sw.bb.sw:                                         ; preds = %for.cond.sw
  %idxprom.sw = sext i32 %i.0.sw to i64
  %arrayidx.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw
  %2 = load i32, ptr %arrayidx.sw, align 4
  %cmp1.sw = icmp eq i32 %2, 0
  br i1 %cmp1.sw, label %for.inc.sw, label %if.end.sw

if.end.sw:                                        ; preds = %sw.bb.sw
  %idxprom2.sw = sext i32 %i.0.sw to i64
  %arrayidx3.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw
  %3 = load i32, ptr %arrayidx3.sw, align 4
  %add.sw = add nsw i32 %3, 1
  store i32 %add.sw, ptr %arrayidx3.sw, align 4
  br label %for.inc.sw

for.inc.sw:                                       ; preds = %if.end.sw, %sw.bb.sw
  %inc.sw = add nsw i32 %i.0.sw, 1
  br label %for.cond.sw, !llvm.loop !6

ipp.sw.ph.case1:                                  ; preds = %ipp.sw.guard.cont
  call void @llvm.assume(i1 %1)
  br label %for.end

ipp.sw.guard.cont2:                               ; preds = %ipp.sw.guard.cont
  %4 = icmp eq i32 %mode, 2
  br i1 %4, label %ipp.sw.ph.case23, label %for.cond

ipp.sw.ph.case23:                                 ; preds = %ipp.sw.guard.cont2
  call void @llvm.assume(i1 %4)
  br label %for.cond.sw25

for.cond.sw25:                                    ; preds = %ipp.sw.ph.case23, %sw.bb5.sw29
  %i.0.sw26 = phi i32 [ 0, %ipp.sw.ph.case23 ], [ %inc.sw44, %sw.bb5.sw29 ]
  %cmp.sw27 = icmp slt i32 %i.0.sw26, %n
  br i1 %cmp.sw27, label %sw.bb5.sw29, label %for.end

sw.bb5.sw29:                                      ; preds = %for.cond.sw25
  %idxprom6.sw30 = sext i32 %i.0.sw26 to i64
  %arrayidx7.sw31 = getelementptr inbounds i32, ptr %A, i64 %idxprom6.sw30
  %5 = load i32, ptr %arrayidx7.sw31, align 4
  %mul.sw32 = mul nsw i32 %5, 2
  store i32 %mul.sw32, ptr %arrayidx7.sw31, align 4
  %inc.sw44 = add nsw i32 %i.0.sw26, 1
  br label %for.cond.sw25, !llvm.loop !6

for.cond:                                         ; preds = %ipp.sw.guard.cont2, %for.inc
  %i.0 = phi i32 [ %inc, %for.inc ], [ 0, %ipp.sw.guard.cont2 ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.inc, label %for.end

for.inc:                                          ; preds = %for.cond
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.sw25, %for.cond.sw, %ipp.sw.ph.case1
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
