; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/switch1_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/switch1_input.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @foo(ptr noundef %a, i32 noundef %n, i32 noundef %flag) #0 {
entry:
  %0 = icmp eq i32 %flag, 0
  br i1 %0, label %ipp.sw.ph.case, label %ipp.sw.guard.cont

ipp.sw.ph.case:                                   ; preds = %entry
  call void @llvm.assume(i1 %0)
  br label %for.cond.sw

ipp.sw.guard.cont:                                ; preds = %entry
  %1 = icmp eq i32 %flag, 1
  br i1 %1, label %ipp.sw.ph.case1, label %ipp.sw.guard.cont2

for.cond.sw:                                      ; preds = %ipp.sw.ph.case, %sw.bb.sw
  %i.0.sw = phi i32 [ 0, %ipp.sw.ph.case ], [ %inc.sw, %sw.bb.sw ]
  %cmp.sw = icmp slt i32 %i.0.sw, %n
  br i1 %cmp.sw, label %sw.bb.sw, label %for.end

sw.bb.sw:                                         ; preds = %for.cond.sw
  %idxprom.sw = sext i32 %i.0.sw to i64
  %arrayidx.sw = getelementptr inbounds i32, ptr %a, i64 %idxprom.sw
  %2 = load i32, ptr %arrayidx.sw, align 4
  %add.sw = add nsw i32 %2, 1
  store i32 %add.sw, ptr %arrayidx.sw, align 4
  %inc.sw = add nsw i32 %i.0.sw, 1
  br label %for.cond.sw, !llvm.loop !6

ipp.sw.ph.case1:                                  ; preds = %ipp.sw.guard.cont
  call void @llvm.assume(i1 %1)
  br label %for.cond.sw3

ipp.sw.guard.cont2:                               ; preds = %ipp.sw.guard.cont
  %3 = icmp eq i32 %flag, 2
  br i1 %3, label %ipp.sw.ph.case26, label %for.cond

for.cond.sw3:                                     ; preds = %ipp.sw.ph.case1, %sw.bb1.sw11
  %i.0.sw4 = phi i32 [ 0, %ipp.sw.ph.case1 ], [ %inc.sw25, %sw.bb1.sw11 ]
  %cmp.sw5 = icmp slt i32 %i.0.sw4, %n
  br i1 %cmp.sw5, label %sw.bb1.sw11, label %for.end

sw.bb1.sw11:                                      ; preds = %for.cond.sw3
  %idxprom2.sw12 = sext i32 %i.0.sw4 to i64
  %arrayidx3.sw13 = getelementptr inbounds i32, ptr %a, i64 %idxprom2.sw12
  %4 = load i32, ptr %arrayidx3.sw13, align 4
  %sub.sw14 = sub nsw i32 %4, 2
  store i32 %sub.sw14, ptr %arrayidx3.sw13, align 4
  %inc.sw25 = add nsw i32 %i.0.sw4, 1
  br label %for.cond.sw3, !llvm.loop !6

ipp.sw.ph.case26:                                 ; preds = %ipp.sw.guard.cont2
  call void @llvm.assume(i1 %3)
  br label %for.cond.sw28

for.cond.sw28:                                    ; preds = %ipp.sw.ph.case26, %sw.bb4.sw32
  %i.0.sw29 = phi i32 [ 0, %ipp.sw.ph.case26 ], [ %inc.sw50, %sw.bb4.sw32 ]
  %cmp.sw30 = icmp slt i32 %i.0.sw29, %n
  br i1 %cmp.sw30, label %sw.bb4.sw32, label %for.end

sw.bb4.sw32:                                      ; preds = %for.cond.sw28
  %idxprom5.sw33 = sext i32 %i.0.sw29 to i64
  %arrayidx6.sw34 = getelementptr inbounds i32, ptr %a, i64 %idxprom5.sw33
  %5 = load i32, ptr %arrayidx6.sw34, align 4
  %mul.sw35 = mul nsw i32 %5, 3
  store i32 %mul.sw35, ptr %arrayidx6.sw34, align 4
  %inc.sw50 = add nsw i32 %i.0.sw29, 1
  br label %for.cond.sw28, !llvm.loop !6

for.cond:                                         ; preds = %ipp.sw.guard.cont2, %sw.default
  %i.0 = phi i32 [ %inc, %sw.default ], [ 0, %ipp.sw.guard.cont2 ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %sw.default, label %for.end

sw.default:                                       ; preds = %for.cond
  %idxprom7 = sext i32 %i.0 to i64
  %arrayidx8 = getelementptr inbounds i32, ptr %a, i64 %idxprom7
  %6 = load i32, ptr %arrayidx8, align 4
  %div = sdiv i32 %6, 4
  store i32 %div, ptr %arrayidx8, align 4
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.sw28, %for.cond.sw3, %for.cond.sw
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
