; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/loop6_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/loop6_input.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @qux(ptr noundef %A, ptr noundef %B, i32 noundef %n, i32 noundef %flag1, i32 noundef %flag2, i32 noundef %flag3) #0 {
entry:
  %tobool = icmp ne i32 %flag1, 0
  %tobool3 = icmp ne i32 %flag2, 0
  %tobool10 = icmp ne i32 %flag3, 0
  br i1 %tobool, label %ipp.unsw.ph.true, label %ipp.unsw.ph.false

ipp.unsw.ph.true:                                 ; preds = %entry
  call void @llvm.assume(i1 %tobool)
  br i1 %tobool3, label %ipp.unsw.ph.true49, label %ipp.unsw.ph.false50

ipp.unsw.ph.false:                                ; preds = %entry
  %0 = xor i1 %tobool, true
  call void @llvm.assume(i1 %0)
  br i1 %tobool3, label %ipp.unsw.ph.true2, label %ipp.unsw.ph.false3

ipp.unsw.ph.true49:                               ; preds = %ipp.unsw.ph.true
  call void @llvm.assume(i1 %tobool3)
  br i1 %tobool10, label %ipp.unsw.ph.true77, label %ipp.unsw.ph.false78

ipp.unsw.ph.false50:                              ; preds = %ipp.unsw.ph.true
  %1 = xor i1 %tobool3, true
  call void @llvm.assume(i1 %1)
  br i1 %tobool10, label %ipp.unsw.ph.true52, label %ipp.unsw.ph.false53

ipp.unsw.ph.true77:                               ; preds = %ipp.unsw.ph.true49
  call void @llvm.assume(i1 %tobool10)
  br label %for.cond.ipp.ipp.ipp

ipp.unsw.ph.false78:                              ; preds = %ipp.unsw.ph.true49
  %2 = xor i1 %tobool10, true
  call void @llvm.assume(i1 %2)
  br label %for.cond.ipp.ipp

for.cond.ipp.ipp.ipp:                             ; preds = %ipp.unsw.ph.true77, %if.then.ipp.ipp.ipp
  %i.0.ipp.ipp.ipp = phi i32 [ 0, %ipp.unsw.ph.true77 ], [ %inc.ipp.ipp.ipp, %if.then.ipp.ipp.ipp ]
  %cmp.ipp.ipp.ipp = icmp slt i32 %i.0.ipp.ipp.ipp, %n
  br i1 %cmp.ipp.ipp.ipp, label %if.then.ipp.ipp.ipp, label %for.end

if.then.ipp.ipp.ipp:                              ; preds = %for.cond.ipp.ipp.ipp
  %idxprom.ipp.ipp.ipp = sext i32 %i.0.ipp.ipp.ipp to i64
  %arrayidx.ipp.ipp.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom.ipp.ipp.ipp
  %3 = load float, ptr %arrayidx.ipp.ipp.ipp, align 4
  %add.ipp.ipp.ipp = fadd float %3, 1.000000e+00
  %idxprom1.ipp.ipp.ipp = sext i32 %i.0.ipp.ipp.ipp to i64
  %arrayidx2.ipp.ipp.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom1.ipp.ipp.ipp
  store float %add.ipp.ipp.ipp, ptr %arrayidx2.ipp.ipp.ipp, align 4
  %idxprom5.ipp.ipp.ipp = sext i32 %i.0.ipp.ipp.ipp to i64
  %arrayidx6.ipp.ipp.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom5.ipp.ipp.ipp
  %4 = load float, ptr %arrayidx6.ipp.ipp.ipp, align 4
  %sub.ipp.ipp.ipp = fsub float %4, 1.000000e+00
  %idxprom7.ipp.ipp.ipp = sext i32 %i.0.ipp.ipp.ipp to i64
  %arrayidx8.ipp.ipp.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom7.ipp.ipp.ipp
  store float %sub.ipp.ipp.ipp, ptr %arrayidx8.ipp.ipp.ipp, align 4
  %idxprom12.ipp.ipp.ipp = sext i32 %i.0.ipp.ipp.ipp to i64
  %arrayidx13.ipp.ipp.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom12.ipp.ipp.ipp
  %5 = load float, ptr %arrayidx13.ipp.ipp.ipp, align 4
  %mul.ipp.ipp.ipp = fmul float %5, 2.000000e+00
  store float %mul.ipp.ipp.ipp, ptr %arrayidx13.ipp.ipp.ipp, align 4
  %idxprom14.ipp.ipp.ipp = sext i32 %i.0.ipp.ipp.ipp to i64
  %arrayidx15.ipp.ipp.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom14.ipp.ipp.ipp
  %6 = load float, ptr %arrayidx15.ipp.ipp.ipp, align 4
  %div.ipp.ipp.ipp = fdiv float %6, 2.000000e+00
  store float %div.ipp.ipp.ipp, ptr %arrayidx15.ipp.ipp.ipp, align 4
  %inc.ipp.ipp.ipp = add nsw i32 %i.0.ipp.ipp.ipp, 1
  br label %for.cond.ipp.ipp.ipp, !llvm.loop !6

for.cond.ipp.ipp:                                 ; preds = %ipp.unsw.ph.false78, %if.then.ipp.ipp
  %i.0.ipp.ipp = phi i32 [ 0, %ipp.unsw.ph.false78 ], [ %inc.ipp.ipp, %if.then.ipp.ipp ]
  %cmp.ipp.ipp = icmp slt i32 %i.0.ipp.ipp, %n
  br i1 %cmp.ipp.ipp, label %if.then.ipp.ipp, label %for.end

if.then.ipp.ipp:                                  ; preds = %for.cond.ipp.ipp
  %idxprom.ipp.ipp = sext i32 %i.0.ipp.ipp to i64
  %arrayidx.ipp.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom.ipp.ipp
  %7 = load float, ptr %arrayidx.ipp.ipp, align 4
  %add.ipp.ipp = fadd float %7, 1.000000e+00
  %idxprom1.ipp.ipp = sext i32 %i.0.ipp.ipp to i64
  %arrayidx2.ipp.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom1.ipp.ipp
  store float %add.ipp.ipp, ptr %arrayidx2.ipp.ipp, align 4
  %idxprom5.ipp.ipp = sext i32 %i.0.ipp.ipp to i64
  %arrayidx6.ipp.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom5.ipp.ipp
  %8 = load float, ptr %arrayidx6.ipp.ipp, align 4
  %sub.ipp.ipp = fsub float %8, 1.000000e+00
  %idxprom7.ipp.ipp = sext i32 %i.0.ipp.ipp to i64
  %arrayidx8.ipp.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom7.ipp.ipp
  store float %sub.ipp.ipp, ptr %arrayidx8.ipp.ipp, align 4
  %inc.ipp.ipp = add nsw i32 %i.0.ipp.ipp, 1
  br label %for.cond.ipp.ipp, !llvm.loop !6

ipp.unsw.ph.true52:                               ; preds = %ipp.unsw.ph.false50
  call void @llvm.assume(i1 %tobool10)
  br label %for.cond.ipp.ipp54

ipp.unsw.ph.false53:                              ; preds = %ipp.unsw.ph.false50
  %9 = xor i1 %tobool10, true
  call void @llvm.assume(i1 %9)
  br label %for.cond.ipp

for.cond.ipp.ipp54:                               ; preds = %ipp.unsw.ph.true52, %if.then.ipp.ipp58
  %i.0.ipp.ipp55 = phi i32 [ 0, %ipp.unsw.ph.true52 ], [ %inc.ipp.ipp75, %if.then.ipp.ipp58 ]
  %cmp.ipp.ipp56 = icmp slt i32 %i.0.ipp.ipp55, %n
  br i1 %cmp.ipp.ipp56, label %if.then.ipp.ipp58, label %for.end

if.then.ipp.ipp58:                                ; preds = %for.cond.ipp.ipp54
  %idxprom.ipp.ipp59 = sext i32 %i.0.ipp.ipp55 to i64
  %arrayidx.ipp.ipp60 = getelementptr inbounds float, ptr %B, i64 %idxprom.ipp.ipp59
  %10 = load float, ptr %arrayidx.ipp.ipp60, align 4
  %add.ipp.ipp61 = fadd float %10, 1.000000e+00
  %idxprom1.ipp.ipp62 = sext i32 %i.0.ipp.ipp55 to i64
  %arrayidx2.ipp.ipp63 = getelementptr inbounds float, ptr %A, i64 %idxprom1.ipp.ipp62
  store float %add.ipp.ipp61, ptr %arrayidx2.ipp.ipp63, align 4
  %idxprom12.ipp.ipp67 = sext i32 %i.0.ipp.ipp55 to i64
  %arrayidx13.ipp.ipp68 = getelementptr inbounds float, ptr %A, i64 %idxprom12.ipp.ipp67
  %11 = load float, ptr %arrayidx13.ipp.ipp68, align 4
  %mul.ipp.ipp69 = fmul float %11, 2.000000e+00
  store float %mul.ipp.ipp69, ptr %arrayidx13.ipp.ipp68, align 4
  %idxprom14.ipp.ipp70 = sext i32 %i.0.ipp.ipp55 to i64
  %arrayidx15.ipp.ipp71 = getelementptr inbounds float, ptr %B, i64 %idxprom14.ipp.ipp70
  %12 = load float, ptr %arrayidx15.ipp.ipp71, align 4
  %div.ipp.ipp72 = fdiv float %12, 2.000000e+00
  store float %div.ipp.ipp72, ptr %arrayidx15.ipp.ipp71, align 4
  %inc.ipp.ipp75 = add nsw i32 %i.0.ipp.ipp55, 1
  br label %for.cond.ipp.ipp54, !llvm.loop !6

for.cond.ipp:                                     ; preds = %ipp.unsw.ph.false53, %if.then.ipp
  %i.0.ipp = phi i32 [ 0, %ipp.unsw.ph.false53 ], [ %inc.ipp, %if.then.ipp ]
  %cmp.ipp = icmp slt i32 %i.0.ipp, %n
  br i1 %cmp.ipp, label %if.then.ipp, label %for.end

if.then.ipp:                                      ; preds = %for.cond.ipp
  %idxprom.ipp = sext i32 %i.0.ipp to i64
  %arrayidx.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom.ipp
  %13 = load float, ptr %arrayidx.ipp, align 4
  %add.ipp = fadd float %13, 1.000000e+00
  %idxprom1.ipp = sext i32 %i.0.ipp to i64
  %arrayidx2.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom1.ipp
  store float %add.ipp, ptr %arrayidx2.ipp, align 4
  %inc.ipp = add nsw i32 %i.0.ipp, 1
  br label %for.cond.ipp, !llvm.loop !6

ipp.unsw.ph.true2:                                ; preds = %ipp.unsw.ph.false
  call void @llvm.assume(i1 %tobool3)
  br i1 %tobool10, label %ipp.unsw.ph.true46, label %ipp.unsw.ph.false47

ipp.unsw.ph.false3:                               ; preds = %ipp.unsw.ph.false
  %14 = xor i1 %tobool3, true
  call void @llvm.assume(i1 %14)
  br i1 %tobool10, label %ipp.unsw.ph.true27, label %ipp.unsw.ph.false28

ipp.unsw.ph.true46:                               ; preds = %ipp.unsw.ph.true2
  call void @llvm.assume(i1 %tobool10)
  br label %for.cond.ipp4.ipp

ipp.unsw.ph.false47:                              ; preds = %ipp.unsw.ph.true2
  %15 = xor i1 %tobool10, true
  call void @llvm.assume(i1 %15)
  br label %for.cond.ipp4

for.cond.ipp4.ipp:                                ; preds = %ipp.unsw.ph.true46, %if.then4.ipp9.ipp
  %i.0.ipp5.ipp = phi i32 [ 0, %ipp.unsw.ph.true46 ], [ %inc.ipp25.ipp, %if.then4.ipp9.ipp ]
  %cmp.ipp6.ipp = icmp slt i32 %i.0.ipp5.ipp, %n
  br i1 %cmp.ipp6.ipp, label %if.then4.ipp9.ipp, label %for.end

if.then4.ipp9.ipp:                                ; preds = %for.cond.ipp4.ipp
  %idxprom5.ipp10.ipp = sext i32 %i.0.ipp5.ipp to i64
  %arrayidx6.ipp11.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom5.ipp10.ipp
  %16 = load float, ptr %arrayidx6.ipp11.ipp, align 4
  %sub.ipp12.ipp = fsub float %16, 1.000000e+00
  %idxprom7.ipp13.ipp = sext i32 %i.0.ipp5.ipp to i64
  %arrayidx8.ipp14.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom7.ipp13.ipp
  store float %sub.ipp12.ipp, ptr %arrayidx8.ipp14.ipp, align 4
  %idxprom12.ipp17.ipp = sext i32 %i.0.ipp5.ipp to i64
  %arrayidx13.ipp18.ipp = getelementptr inbounds float, ptr %A, i64 %idxprom12.ipp17.ipp
  %17 = load float, ptr %arrayidx13.ipp18.ipp, align 4
  %mul.ipp19.ipp = fmul float %17, 2.000000e+00
  store float %mul.ipp19.ipp, ptr %arrayidx13.ipp18.ipp, align 4
  %idxprom14.ipp20.ipp = sext i32 %i.0.ipp5.ipp to i64
  %arrayidx15.ipp21.ipp = getelementptr inbounds float, ptr %B, i64 %idxprom14.ipp20.ipp
  %18 = load float, ptr %arrayidx15.ipp21.ipp, align 4
  %div.ipp22.ipp = fdiv float %18, 2.000000e+00
  store float %div.ipp22.ipp, ptr %arrayidx15.ipp21.ipp, align 4
  %inc.ipp25.ipp = add nsw i32 %i.0.ipp5.ipp, 1
  br label %for.cond.ipp4.ipp, !llvm.loop !6

for.cond.ipp4:                                    ; preds = %ipp.unsw.ph.false47, %if.then4.ipp9
  %i.0.ipp5 = phi i32 [ 0, %ipp.unsw.ph.false47 ], [ %inc.ipp25, %if.then4.ipp9 ]
  %cmp.ipp6 = icmp slt i32 %i.0.ipp5, %n
  br i1 %cmp.ipp6, label %if.then4.ipp9, label %for.end

if.then4.ipp9:                                    ; preds = %for.cond.ipp4
  %idxprom5.ipp10 = sext i32 %i.0.ipp5 to i64
  %arrayidx6.ipp11 = getelementptr inbounds float, ptr %B, i64 %idxprom5.ipp10
  %19 = load float, ptr %arrayidx6.ipp11, align 4
  %sub.ipp12 = fsub float %19, 1.000000e+00
  %idxprom7.ipp13 = sext i32 %i.0.ipp5 to i64
  %arrayidx8.ipp14 = getelementptr inbounds float, ptr %A, i64 %idxprom7.ipp13
  store float %sub.ipp12, ptr %arrayidx8.ipp14, align 4
  %inc.ipp25 = add nsw i32 %i.0.ipp5, 1
  br label %for.cond.ipp4, !llvm.loop !6

ipp.unsw.ph.true27:                               ; preds = %ipp.unsw.ph.false3
  call void @llvm.assume(i1 %tobool10)
  br label %for.cond.ipp29

ipp.unsw.ph.false28:                              ; preds = %ipp.unsw.ph.false3
  %20 = xor i1 %tobool10, true
  call void @llvm.assume(i1 %20)
  br label %for.cond

for.cond.ipp29:                                   ; preds = %ipp.unsw.ph.true27, %if.then11.ipp35
  %i.0.ipp30 = phi i32 [ 0, %ipp.unsw.ph.true27 ], [ %inc.ipp44, %if.then11.ipp35 ]
  %cmp.ipp31 = icmp slt i32 %i.0.ipp30, %n
  br i1 %cmp.ipp31, label %if.then11.ipp35, label %for.end

if.then11.ipp35:                                  ; preds = %for.cond.ipp29
  %idxprom12.ipp36 = sext i32 %i.0.ipp30 to i64
  %arrayidx13.ipp37 = getelementptr inbounds float, ptr %A, i64 %idxprom12.ipp36
  %21 = load float, ptr %arrayidx13.ipp37, align 4
  %mul.ipp38 = fmul float %21, 2.000000e+00
  store float %mul.ipp38, ptr %arrayidx13.ipp37, align 4
  %idxprom14.ipp39 = sext i32 %i.0.ipp30 to i64
  %arrayidx15.ipp40 = getelementptr inbounds float, ptr %B, i64 %idxprom14.ipp39
  %22 = load float, ptr %arrayidx15.ipp40, align 4
  %div.ipp41 = fdiv float %22, 2.000000e+00
  store float %div.ipp41, ptr %arrayidx15.ipp40, align 4
  %inc.ipp44 = add nsw i32 %i.0.ipp30, 1
  br label %for.cond.ipp29, !llvm.loop !6

for.cond:                                         ; preds = %ipp.unsw.ph.false28, %for.inc
  %i.0 = phi i32 [ 0, %ipp.unsw.ph.false28 ], [ %inc, %for.inc ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.inc, label %for.end

for.inc:                                          ; preds = %for.cond
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.ipp29, %for.cond.ipp4, %for.cond.ipp4.ipp, %for.cond.ipp, %for.cond.ipp.ipp54, %for.cond.ipp.ipp, %for.cond.ipp.ipp.ipp
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
