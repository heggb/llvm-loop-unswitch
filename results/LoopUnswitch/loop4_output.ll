; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/loop4_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/loop4_input.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @foo(ptr noundef %A, i32 noundef %n, i32 noundef %flag1, i32 noundef %flag2) #0 {
entry:
  %tobool = icmp ne i32 %flag1, 0
  %tobool1 = icmp ne i32 %flag2, 0
  br i1 %tobool, label %ipp.unsw.ph.true, label %ipp.unsw.ph.false

ipp.unsw.ph.true:                                 ; preds = %entry
  call void @llvm.assume(i1 %tobool)
  br i1 %tobool1, label %ipp.unsw.ph.true17, label %ipp.unsw.ph.false18

ipp.unsw.ph.false:                                ; preds = %entry
  %0 = xor i1 %tobool, true
  call void @llvm.assume(i1 %0)
  br i1 %tobool1, label %ipp.unsw.ph.true2, label %ipp.unsw.ph.false3

ipp.unsw.ph.true17:                               ; preds = %ipp.unsw.ph.true
  call void @llvm.assume(i1 %tobool1)
  br label %for.cond.ipp.ipp

ipp.unsw.ph.false18:                              ; preds = %ipp.unsw.ph.true
  %1 = xor i1 %tobool1, true
  call void @llvm.assume(i1 %1)
  br label %for.cond.ipp

for.cond.ipp.ipp:                                 ; preds = %ipp.unsw.ph.true17, %if.then.ipp.ipp
  %i.0.ipp.ipp = phi i32 [ 0, %ipp.unsw.ph.true17 ], [ %inc.ipp.ipp, %if.then.ipp.ipp ]
  %cmp.ipp.ipp = icmp slt i32 %i.0.ipp.ipp, %n
  br i1 %cmp.ipp.ipp, label %if.then.ipp.ipp, label %for.end

if.then.ipp.ipp:                                  ; preds = %for.cond.ipp.ipp
  %idxprom.ipp.ipp = sext i32 %i.0.ipp.ipp to i64
  %arrayidx.ipp.ipp = getelementptr inbounds i32, ptr %A, i64 %idxprom.ipp.ipp
  %2 = load i32, ptr %arrayidx.ipp.ipp, align 4
  %add.ipp.ipp = add nsw i32 %2, 1
  store i32 %add.ipp.ipp, ptr %arrayidx.ipp.ipp, align 4
  %idxprom3.ipp.ipp = sext i32 %i.0.ipp.ipp to i64
  %arrayidx4.ipp.ipp = getelementptr inbounds i32, ptr %A, i64 %idxprom3.ipp.ipp
  %3 = load i32, ptr %arrayidx4.ipp.ipp, align 4
  %mul.ipp.ipp = mul nsw i32 %3, 2
  store i32 %mul.ipp.ipp, ptr %arrayidx4.ipp.ipp, align 4
  %inc.ipp.ipp = add nsw i32 %i.0.ipp.ipp, 1
  br label %for.cond.ipp.ipp, !llvm.loop !6

for.cond.ipp:                                     ; preds = %ipp.unsw.ph.false18, %if.then.ipp
  %i.0.ipp = phi i32 [ 0, %ipp.unsw.ph.false18 ], [ %inc.ipp, %if.then.ipp ]
  %cmp.ipp = icmp slt i32 %i.0.ipp, %n
  br i1 %cmp.ipp, label %if.then.ipp, label %for.end

if.then.ipp:                                      ; preds = %for.cond.ipp
  %idxprom.ipp = sext i32 %i.0.ipp to i64
  %arrayidx.ipp = getelementptr inbounds i32, ptr %A, i64 %idxprom.ipp
  %4 = load i32, ptr %arrayidx.ipp, align 4
  %add.ipp = add nsw i32 %4, 1
  store i32 %add.ipp, ptr %arrayidx.ipp, align 4
  %inc.ipp = add nsw i32 %i.0.ipp, 1
  br label %for.cond.ipp, !llvm.loop !6

ipp.unsw.ph.true2:                                ; preds = %ipp.unsw.ph.false
  call void @llvm.assume(i1 %tobool1)
  br label %for.cond.ipp4

ipp.unsw.ph.false3:                               ; preds = %ipp.unsw.ph.false
  %5 = xor i1 %tobool1, true
  call void @llvm.assume(i1 %5)
  br label %for.cond

for.cond.ipp4:                                    ; preds = %ipp.unsw.ph.true2, %if.then2.ipp9
  %i.0.ipp5 = phi i32 [ 0, %ipp.unsw.ph.true2 ], [ %inc.ipp15, %if.then2.ipp9 ]
  %cmp.ipp6 = icmp slt i32 %i.0.ipp5, %n
  br i1 %cmp.ipp6, label %if.then2.ipp9, label %for.end

if.then2.ipp9:                                    ; preds = %for.cond.ipp4
  %idxprom3.ipp10 = sext i32 %i.0.ipp5 to i64
  %arrayidx4.ipp11 = getelementptr inbounds i32, ptr %A, i64 %idxprom3.ipp10
  %6 = load i32, ptr %arrayidx4.ipp11, align 4
  %mul.ipp12 = mul nsw i32 %6, 2
  store i32 %mul.ipp12, ptr %arrayidx4.ipp11, align 4
  %inc.ipp15 = add nsw i32 %i.0.ipp5, 1
  br label %for.cond.ipp4, !llvm.loop !6

for.cond:                                         ; preds = %ipp.unsw.ph.false3, %for.inc
  %i.0 = phi i32 [ 0, %ipp.unsw.ph.false3 ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.inc, label %for.end

for.inc:                                          ; preds = %for.cond
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.ipp4, %for.cond.ipp, %for.cond.ipp.ipp
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
