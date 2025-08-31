; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/switch4_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/switch4_input.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @foo(ptr noundef %A, ptr noundef %B, i32 noundef %n, i32 noundef %flag1, i32 noundef %flag2) #0 {
entry:
  %0 = icmp eq i32 %flag1, 0
  br i1 %0, label %ipp.sw.ph.case, label %ipp.sw.guard.cont

ipp.sw.ph.case:                                   ; preds = %entry
  call void @llvm.assume(i1 %0)
  %1 = icmp eq i32 %flag2, 0
  br i1 %1, label %ipp.sw.ph.case95, label %ipp.sw.guard.cont96

ipp.sw.guard.cont:                                ; preds = %entry
  %2 = icmp eq i32 %flag1, 1
  br i1 %2, label %ipp.sw.ph.case1, label %ipp.sw.ph.default

ipp.sw.ph.case95:                                 ; preds = %ipp.sw.ph.case
  call void @llvm.assume(i1 %1)
  br label %for.cond.sw.sw

ipp.sw.guard.cont96:                              ; preds = %ipp.sw.ph.case
  %3 = icmp eq i32 %flag2, 1
  br i1 %3, label %ipp.sw.ph.case97, label %for.cond.sw

for.cond.sw.sw:                                   ; preds = %ipp.sw.ph.case95, %sw.bb.sw.sw
  %i.0.sw.sw = phi i32 [ 0, %ipp.sw.ph.case95 ], [ %inc.sw.sw, %sw.bb.sw.sw ]
  %cmp.sw.sw = icmp slt i32 %i.0.sw.sw, %n
  br i1 %cmp.sw.sw, label %sw.bb.sw.sw, label %for.end

sw.bb.sw.sw:                                      ; preds = %for.cond.sw.sw
  %idxprom.sw.sw = sext i32 %i.0.sw.sw to i64
  %arrayidx.sw.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw
  %4 = load i32, ptr %arrayidx.sw.sw, align 4
  %add.sw.sw = add nsw i32 %4, 1
  store i32 %add.sw.sw, ptr %arrayidx.sw.sw, align 4
  %idxprom5.sw.sw = sext i32 %i.0.sw.sw to i64
  %arrayidx6.sw.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw.sw
  %5 = load i32, ptr %arrayidx6.sw.sw, align 4
  %add7.sw.sw = add nsw i32 %5, 2
  store i32 %add7.sw.sw, ptr %arrayidx6.sw.sw, align 4
  %inc.sw.sw = add nsw i32 %i.0.sw.sw, 1
  br label %for.cond.sw.sw, !llvm.loop !6

ipp.sw.ph.case97:                                 ; preds = %ipp.sw.guard.cont96
  call void @llvm.assume(i1 %3)
  br label %for.cond.sw.sw99

for.cond.sw.sw99:                                 ; preds = %ipp.sw.ph.case97, %sw.bb.sw.sw103
  %i.0.sw.sw100 = phi i32 [ 0, %ipp.sw.ph.case97 ], [ %inc.sw.sw118, %sw.bb.sw.sw103 ]
  %cmp.sw.sw101 = icmp slt i32 %i.0.sw.sw100, %n
  br i1 %cmp.sw.sw101, label %sw.bb.sw.sw103, label %for.end

sw.bb.sw.sw103:                                   ; preds = %for.cond.sw.sw99
  %idxprom.sw.sw104 = sext i32 %i.0.sw.sw100 to i64
  %arrayidx.sw.sw105 = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw104
  %6 = load i32, ptr %arrayidx.sw.sw105, align 4
  %add.sw.sw106 = add nsw i32 %6, 1
  store i32 %add.sw.sw106, ptr %arrayidx.sw.sw105, align 4
  %idxprom9.sw.sw109 = sext i32 %i.0.sw.sw100 to i64
  %arrayidx10.sw.sw110 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw.sw109
  %7 = load i32, ptr %arrayidx10.sw.sw110, align 4
  %sub11.sw.sw111 = sub nsw i32 %7, 2
  store i32 %sub11.sw.sw111, ptr %arrayidx10.sw.sw110, align 4
  %inc.sw.sw118 = add nsw i32 %i.0.sw.sw100, 1
  br label %for.cond.sw.sw99, !llvm.loop !6

for.cond.sw:                                      ; preds = %ipp.sw.guard.cont96, %sw.bb.sw
  %i.0.sw = phi i32 [ %inc.sw, %sw.bb.sw ], [ 0, %ipp.sw.guard.cont96 ]
  %cmp.sw = icmp slt i32 %i.0.sw, %n
  br i1 %cmp.sw, label %sw.bb.sw, label %for.end

sw.bb.sw:                                         ; preds = %for.cond.sw
  %idxprom.sw = sext i32 %i.0.sw to i64
  %arrayidx.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw
  %8 = load i32, ptr %arrayidx.sw, align 4
  %add.sw = add nsw i32 %8, 1
  store i32 %add.sw, ptr %arrayidx.sw, align 4
  %inc.sw = add nsw i32 %i.0.sw, 1
  br label %for.cond.sw, !llvm.loop !6

ipp.sw.ph.case1:                                  ; preds = %ipp.sw.guard.cont
  call void @llvm.assume(i1 %2)
  %9 = icmp eq i32 %flag2, 0
  br i1 %9, label %ipp.sw.ph.case68, label %ipp.sw.guard.cont69

ipp.sw.ph.case68:                                 ; preds = %ipp.sw.ph.case1
  call void @llvm.assume(i1 %9)
  br label %for.cond.sw3.sw

ipp.sw.guard.cont69:                              ; preds = %ipp.sw.ph.case1
  %10 = icmp eq i32 %flag2, 1
  br i1 %10, label %ipp.sw.ph.case70, label %for.cond.sw3

for.cond.sw3.sw:                                  ; preds = %ipp.sw.ph.case68, %sw.bb1.sw7.sw
  %i.0.sw4.sw = phi i32 [ 0, %ipp.sw.ph.case68 ], [ %inc.sw26.sw, %sw.bb1.sw7.sw ]
  %cmp.sw5.sw = icmp slt i32 %i.0.sw4.sw, %n
  br i1 %cmp.sw5.sw, label %sw.bb1.sw7.sw, label %for.end

sw.bb1.sw7.sw:                                    ; preds = %for.cond.sw3.sw
  %idxprom2.sw8.sw = sext i32 %i.0.sw4.sw to i64
  %arrayidx3.sw9.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw
  %11 = load i32, ptr %arrayidx3.sw9.sw, align 4
  %sub.sw10.sw = sub nsw i32 %11, 1
  store i32 %sub.sw10.sw, ptr %arrayidx3.sw9.sw, align 4
  %idxprom5.sw21.sw = sext i32 %i.0.sw4.sw to i64
  %arrayidx6.sw22.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw21.sw
  %12 = load i32, ptr %arrayidx6.sw22.sw, align 4
  %add7.sw23.sw = add nsw i32 %12, 2
  store i32 %add7.sw23.sw, ptr %arrayidx6.sw22.sw, align 4
  %inc.sw26.sw = add nsw i32 %i.0.sw4.sw, 1
  br label %for.cond.sw3.sw, !llvm.loop !6

ipp.sw.ph.case70:                                 ; preds = %ipp.sw.guard.cont69
  call void @llvm.assume(i1 %10)
  br label %for.cond.sw3.sw72

for.cond.sw3.sw72:                                ; preds = %ipp.sw.ph.case70, %sw.bb1.sw7.sw76
  %i.0.sw4.sw73 = phi i32 [ 0, %ipp.sw.ph.case70 ], [ %inc.sw26.sw91, %sw.bb1.sw7.sw76 ]
  %cmp.sw5.sw74 = icmp slt i32 %i.0.sw4.sw73, %n
  br i1 %cmp.sw5.sw74, label %sw.bb1.sw7.sw76, label %for.end

sw.bb1.sw7.sw76:                                  ; preds = %for.cond.sw3.sw72
  %idxprom2.sw8.sw77 = sext i32 %i.0.sw4.sw73 to i64
  %arrayidx3.sw9.sw78 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw77
  %13 = load i32, ptr %arrayidx3.sw9.sw78, align 4
  %sub.sw10.sw79 = sub nsw i32 %13, 1
  store i32 %sub.sw10.sw79, ptr %arrayidx3.sw9.sw78, align 4
  %idxprom9.sw17.sw82 = sext i32 %i.0.sw4.sw73 to i64
  %arrayidx10.sw18.sw83 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw17.sw82
  %14 = load i32, ptr %arrayidx10.sw18.sw83, align 4
  %sub11.sw19.sw84 = sub nsw i32 %14, 2
  store i32 %sub11.sw19.sw84, ptr %arrayidx10.sw18.sw83, align 4
  %inc.sw26.sw91 = add nsw i32 %i.0.sw4.sw73, 1
  br label %for.cond.sw3.sw72, !llvm.loop !6

for.cond.sw3:                                     ; preds = %ipp.sw.guard.cont69, %sw.bb1.sw7
  %i.0.sw4 = phi i32 [ %inc.sw26, %sw.bb1.sw7 ], [ 0, %ipp.sw.guard.cont69 ]
  %cmp.sw5 = icmp slt i32 %i.0.sw4, %n
  br i1 %cmp.sw5, label %sw.bb1.sw7, label %for.end

sw.bb1.sw7:                                       ; preds = %for.cond.sw3
  %idxprom2.sw8 = sext i32 %i.0.sw4 to i64
  %arrayidx3.sw9 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8
  %15 = load i32, ptr %arrayidx3.sw9, align 4
  %sub.sw10 = sub nsw i32 %15, 1
  store i32 %sub.sw10, ptr %arrayidx3.sw9, align 4
  %inc.sw26 = add nsw i32 %i.0.sw4, 1
  br label %for.cond.sw3, !llvm.loop !6

ipp.sw.ph.default:                                ; preds = %ipp.sw.guard.cont
  %16 = icmp eq i32 %flag2, 0
  br i1 %16, label %ipp.sw.ph.case29, label %ipp.sw.guard.cont30

ipp.sw.ph.case29:                                 ; preds = %ipp.sw.ph.default
  call void @llvm.assume(i1 %16)
  br label %for.cond.sw31

ipp.sw.guard.cont30:                              ; preds = %ipp.sw.ph.default
  %17 = icmp eq i32 %flag2, 1
  br i1 %17, label %ipp.sw.ph.case47, label %for.cond

for.cond.sw31:                                    ; preds = %ipp.sw.ph.case29, %sw.bb4.sw40
  %i.0.sw32 = phi i32 [ 0, %ipp.sw.ph.case29 ], [ %inc.sw46, %sw.bb4.sw40 ]
  %cmp.sw33 = icmp slt i32 %i.0.sw32, %n
  br i1 %cmp.sw33, label %sw.bb4.sw40, label %for.end

sw.bb4.sw40:                                      ; preds = %for.cond.sw31
  %idxprom5.sw41 = sext i32 %i.0.sw32 to i64
  %arrayidx6.sw42 = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw41
  %18 = load i32, ptr %arrayidx6.sw42, align 4
  %add7.sw43 = add nsw i32 %18, 2
  store i32 %add7.sw43, ptr %arrayidx6.sw42, align 4
  %inc.sw46 = add nsw i32 %i.0.sw32, 1
  br label %for.cond.sw31, !llvm.loop !6

ipp.sw.ph.case47:                                 ; preds = %ipp.sw.guard.cont30
  call void @llvm.assume(i1 %17)
  br label %for.cond.sw49

for.cond.sw49:                                    ; preds = %ipp.sw.ph.case47, %sw.bb8.sw54
  %i.0.sw50 = phi i32 [ 0, %ipp.sw.ph.case47 ], [ %inc.sw64, %sw.bb8.sw54 ]
  %cmp.sw51 = icmp slt i32 %i.0.sw50, %n
  br i1 %cmp.sw51, label %sw.bb8.sw54, label %for.end

sw.bb8.sw54:                                      ; preds = %for.cond.sw49
  %idxprom9.sw55 = sext i32 %i.0.sw50 to i64
  %arrayidx10.sw56 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw55
  %19 = load i32, ptr %arrayidx10.sw56, align 4
  %sub11.sw57 = sub nsw i32 %19, 2
  store i32 %sub11.sw57, ptr %arrayidx10.sw56, align 4
  %inc.sw64 = add nsw i32 %i.0.sw50, 1
  br label %for.cond.sw49, !llvm.loop !6

for.cond:                                         ; preds = %ipp.sw.guard.cont30, %for.inc
  %i.0 = phi i32 [ %inc, %for.inc ], [ 0, %ipp.sw.guard.cont30 ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.inc, label %for.end

for.inc:                                          ; preds = %for.cond
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.sw49, %for.cond.sw31, %for.cond.sw3, %for.cond.sw3.sw72, %for.cond.sw3.sw, %for.cond.sw, %for.cond.sw.sw99, %for.cond.sw.sw
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
