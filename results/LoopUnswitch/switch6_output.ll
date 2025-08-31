; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/switch6_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/switch6_input.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define dso_local void @foo(ptr noundef %A, ptr noundef %B, i32 noundef %n, i32 noundef %flag1, i32 noundef %flag2, i32 noundef %flag3) #0 {
entry:
  %0 = icmp eq i32 %flag1, 0
  br i1 %0, label %ipp.sw.ph.case, label %ipp.sw.guard.cont

ipp.sw.ph.case:                                   ; preds = %entry
  call void @llvm.assume(i1 %0)
  %1 = icmp eq i32 %flag2, 0
  br i1 %1, label %ipp.sw.ph.case341, label %ipp.sw.guard.cont342

ipp.sw.guard.cont:                                ; preds = %entry
  %2 = icmp eq i32 %flag1, 1
  br i1 %2, label %ipp.sw.ph.case1, label %ipp.sw.ph.default

ipp.sw.ph.case341:                                ; preds = %ipp.sw.ph.case
  call void @llvm.assume(i1 %1)
  %3 = icmp eq i32 %flag3, 0
  br i1 %3, label %ipp.sw.ph.case458, label %ipp.sw.guard.cont459

ipp.sw.guard.cont342:                             ; preds = %ipp.sw.ph.case
  %4 = icmp eq i32 %flag2, 1
  br i1 %4, label %ipp.sw.ph.case343, label %ipp.sw.ph.default374

ipp.sw.ph.case458:                                ; preds = %ipp.sw.ph.case341
  call void @llvm.assume(i1 %3)
  br label %for.cond.sw.sw.sw

ipp.sw.guard.cont459:                             ; preds = %ipp.sw.ph.case341
  %5 = icmp eq i32 %flag3, 1
  br i1 %5, label %ipp.sw.ph.case460, label %for.cond.sw.sw

for.cond.sw.sw.sw:                                ; preds = %ipp.sw.ph.case458, %sw.bb.sw.sw.sw
  %i.0.sw.sw.sw = phi i32 [ 0, %ipp.sw.ph.case458 ], [ %inc.sw.sw.sw, %sw.bb.sw.sw.sw ]
  %cmp.sw.sw.sw = icmp slt i32 %i.0.sw.sw.sw, %n
  br i1 %cmp.sw.sw.sw, label %sw.bb.sw.sw.sw, label %for.end

sw.bb.sw.sw.sw:                                   ; preds = %for.cond.sw.sw.sw
  %idxprom.sw.sw.sw = sext i32 %i.0.sw.sw.sw to i64
  %arrayidx.sw.sw.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw.sw
  %6 = load i32, ptr %arrayidx.sw.sw.sw, align 4
  %add.sw.sw.sw = add nsw i32 %6, 1
  store i32 %add.sw.sw.sw, ptr %arrayidx.sw.sw.sw, align 4
  %idxprom5.sw.sw.sw = sext i32 %i.0.sw.sw.sw to i64
  %arrayidx6.sw.sw.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw.sw.sw
  %7 = load i32, ptr %arrayidx6.sw.sw.sw, align 4
  %add7.sw.sw.sw = add nsw i32 %7, 2
  store i32 %add7.sw.sw.sw, ptr %arrayidx6.sw.sw.sw, align 4
  %idxprom14.sw.sw.sw = sext i32 %i.0.sw.sw.sw to i64
  %arrayidx15.sw.sw.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw.sw.sw
  %8 = load i32, ptr %arrayidx15.sw.sw.sw, align 4
  %add16.sw.sw.sw = add nsw i32 %8, 3
  store i32 %add16.sw.sw.sw, ptr %arrayidx15.sw.sw.sw, align 4
  %inc.sw.sw.sw = add nsw i32 %i.0.sw.sw.sw, 1
  br label %for.cond.sw.sw.sw, !llvm.loop !6

ipp.sw.ph.case460:                                ; preds = %ipp.sw.guard.cont459
  call void @llvm.assume(i1 %5)
  br label %for.cond.sw.sw.sw462

for.cond.sw.sw.sw462:                             ; preds = %ipp.sw.ph.case460, %sw.bb.sw.sw.sw466
  %i.0.sw.sw.sw463 = phi i32 [ 0, %ipp.sw.ph.case460 ], [ %inc.sw.sw.sw486, %sw.bb.sw.sw.sw466 ]
  %cmp.sw.sw.sw464 = icmp slt i32 %i.0.sw.sw.sw463, %n
  br i1 %cmp.sw.sw.sw464, label %sw.bb.sw.sw.sw466, label %for.end

sw.bb.sw.sw.sw466:                                ; preds = %for.cond.sw.sw.sw462
  %idxprom.sw.sw.sw467 = sext i32 %i.0.sw.sw.sw463 to i64
  %arrayidx.sw.sw.sw468 = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw.sw467
  %9 = load i32, ptr %arrayidx.sw.sw.sw468, align 4
  %add.sw.sw.sw469 = add nsw i32 %9, 1
  store i32 %add.sw.sw.sw469, ptr %arrayidx.sw.sw.sw468, align 4
  %idxprom5.sw.sw.sw472 = sext i32 %i.0.sw.sw.sw463 to i64
  %arrayidx6.sw.sw.sw473 = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw.sw.sw472
  %10 = load i32, ptr %arrayidx6.sw.sw.sw473, align 4
  %add7.sw.sw.sw474 = add nsw i32 %10, 2
  store i32 %add7.sw.sw.sw474, ptr %arrayidx6.sw.sw.sw473, align 4
  %idxprom18.sw.sw.sw477 = sext i32 %i.0.sw.sw.sw463 to i64
  %arrayidx19.sw.sw.sw478 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw.sw.sw477
  %11 = load i32, ptr %arrayidx19.sw.sw.sw478, align 4
  %sub20.sw.sw.sw479 = sub nsw i32 %11, 3
  store i32 %sub20.sw.sw.sw479, ptr %arrayidx19.sw.sw.sw478, align 4
  %inc.sw.sw.sw486 = add nsw i32 %i.0.sw.sw.sw463, 1
  br label %for.cond.sw.sw.sw462, !llvm.loop !6

for.cond.sw.sw:                                   ; preds = %ipp.sw.guard.cont459, %sw.bb.sw.sw
  %i.0.sw.sw = phi i32 [ %inc.sw.sw, %sw.bb.sw.sw ], [ 0, %ipp.sw.guard.cont459 ]
  %cmp.sw.sw = icmp slt i32 %i.0.sw.sw, %n
  br i1 %cmp.sw.sw, label %sw.bb.sw.sw, label %for.end

sw.bb.sw.sw:                                      ; preds = %for.cond.sw.sw
  %idxprom.sw.sw = sext i32 %i.0.sw.sw to i64
  %arrayidx.sw.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw
  %12 = load i32, ptr %arrayidx.sw.sw, align 4
  %add.sw.sw = add nsw i32 %12, 1
  store i32 %add.sw.sw, ptr %arrayidx.sw.sw, align 4
  %idxprom5.sw.sw = sext i32 %i.0.sw.sw to i64
  %arrayidx6.sw.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw.sw
  %13 = load i32, ptr %arrayidx6.sw.sw, align 4
  %add7.sw.sw = add nsw i32 %13, 2
  store i32 %add7.sw.sw, ptr %arrayidx6.sw.sw, align 4
  %inc.sw.sw = add nsw i32 %i.0.sw.sw, 1
  br label %for.cond.sw.sw, !llvm.loop !6

ipp.sw.ph.case343:                                ; preds = %ipp.sw.guard.cont342
  call void @llvm.assume(i1 %4)
  %14 = icmp eq i32 %flag3, 0
  br i1 %14, label %ipp.sw.ph.case426, label %ipp.sw.guard.cont427

ipp.sw.ph.case426:                                ; preds = %ipp.sw.ph.case343
  call void @llvm.assume(i1 %14)
  br label %for.cond.sw.sw345.sw

ipp.sw.guard.cont427:                             ; preds = %ipp.sw.ph.case343
  %15 = icmp eq i32 %flag3, 1
  br i1 %15, label %ipp.sw.ph.case428, label %for.cond.sw.sw345

for.cond.sw.sw345.sw:                             ; preds = %ipp.sw.ph.case426, %sw.bb.sw.sw349.sw
  %i.0.sw.sw346.sw = phi i32 [ 0, %ipp.sw.ph.case426 ], [ %inc.sw.sw373.sw, %sw.bb.sw.sw349.sw ]
  %cmp.sw.sw347.sw = icmp slt i32 %i.0.sw.sw346.sw, %n
  br i1 %cmp.sw.sw347.sw, label %sw.bb.sw.sw349.sw, label %for.end

sw.bb.sw.sw349.sw:                                ; preds = %for.cond.sw.sw345.sw
  %idxprom.sw.sw350.sw = sext i32 %i.0.sw.sw346.sw to i64
  %arrayidx.sw.sw351.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw350.sw
  %16 = load i32, ptr %arrayidx.sw.sw351.sw, align 4
  %add.sw.sw352.sw = add nsw i32 %16, 1
  store i32 %add.sw.sw352.sw, ptr %arrayidx.sw.sw351.sw, align 4
  %idxprom9.sw.sw355.sw = sext i32 %i.0.sw.sw346.sw to i64
  %arrayidx10.sw.sw356.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw.sw355.sw
  %17 = load i32, ptr %arrayidx10.sw.sw356.sw, align 4
  %sub11.sw.sw357.sw = sub nsw i32 %17, 2
  store i32 %sub11.sw.sw357.sw, ptr %arrayidx10.sw.sw356.sw, align 4
  %idxprom14.sw.sw368.sw = sext i32 %i.0.sw.sw346.sw to i64
  %arrayidx15.sw.sw369.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw.sw368.sw
  %18 = load i32, ptr %arrayidx15.sw.sw369.sw, align 4
  %add16.sw.sw370.sw = add nsw i32 %18, 3
  store i32 %add16.sw.sw370.sw, ptr %arrayidx15.sw.sw369.sw, align 4
  %inc.sw.sw373.sw = add nsw i32 %i.0.sw.sw346.sw, 1
  br label %for.cond.sw.sw345.sw, !llvm.loop !6

ipp.sw.ph.case428:                                ; preds = %ipp.sw.guard.cont427
  call void @llvm.assume(i1 %15)
  br label %for.cond.sw.sw345.sw430

for.cond.sw.sw345.sw430:                          ; preds = %ipp.sw.ph.case428, %sw.bb.sw.sw349.sw434
  %i.0.sw.sw346.sw431 = phi i32 [ 0, %ipp.sw.ph.case428 ], [ %inc.sw.sw373.sw454, %sw.bb.sw.sw349.sw434 ]
  %cmp.sw.sw347.sw432 = icmp slt i32 %i.0.sw.sw346.sw431, %n
  br i1 %cmp.sw.sw347.sw432, label %sw.bb.sw.sw349.sw434, label %for.end

sw.bb.sw.sw349.sw434:                             ; preds = %for.cond.sw.sw345.sw430
  %idxprom.sw.sw350.sw435 = sext i32 %i.0.sw.sw346.sw431 to i64
  %arrayidx.sw.sw351.sw436 = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw350.sw435
  %19 = load i32, ptr %arrayidx.sw.sw351.sw436, align 4
  %add.sw.sw352.sw437 = add nsw i32 %19, 1
  store i32 %add.sw.sw352.sw437, ptr %arrayidx.sw.sw351.sw436, align 4
  %idxprom9.sw.sw355.sw440 = sext i32 %i.0.sw.sw346.sw431 to i64
  %arrayidx10.sw.sw356.sw441 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw.sw355.sw440
  %20 = load i32, ptr %arrayidx10.sw.sw356.sw441, align 4
  %sub11.sw.sw357.sw442 = sub nsw i32 %20, 2
  store i32 %sub11.sw.sw357.sw442, ptr %arrayidx10.sw.sw356.sw441, align 4
  %idxprom18.sw.sw364.sw445 = sext i32 %i.0.sw.sw346.sw431 to i64
  %arrayidx19.sw.sw365.sw446 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw.sw364.sw445
  %21 = load i32, ptr %arrayidx19.sw.sw365.sw446, align 4
  %sub20.sw.sw366.sw447 = sub nsw i32 %21, 3
  store i32 %sub20.sw.sw366.sw447, ptr %arrayidx19.sw.sw365.sw446, align 4
  %inc.sw.sw373.sw454 = add nsw i32 %i.0.sw.sw346.sw431, 1
  br label %for.cond.sw.sw345.sw430, !llvm.loop !6

for.cond.sw.sw345:                                ; preds = %ipp.sw.guard.cont427, %sw.bb.sw.sw349
  %i.0.sw.sw346 = phi i32 [ %inc.sw.sw373, %sw.bb.sw.sw349 ], [ 0, %ipp.sw.guard.cont427 ]
  %cmp.sw.sw347 = icmp slt i32 %i.0.sw.sw346, %n
  br i1 %cmp.sw.sw347, label %sw.bb.sw.sw349, label %for.end

sw.bb.sw.sw349:                                   ; preds = %for.cond.sw.sw345
  %idxprom.sw.sw350 = sext i32 %i.0.sw.sw346 to i64
  %arrayidx.sw.sw351 = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw350
  %22 = load i32, ptr %arrayidx.sw.sw351, align 4
  %add.sw.sw352 = add nsw i32 %22, 1
  store i32 %add.sw.sw352, ptr %arrayidx.sw.sw351, align 4
  %idxprom9.sw.sw355 = sext i32 %i.0.sw.sw346 to i64
  %arrayidx10.sw.sw356 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw.sw355
  %23 = load i32, ptr %arrayidx10.sw.sw356, align 4
  %sub11.sw.sw357 = sub nsw i32 %23, 2
  store i32 %sub11.sw.sw357, ptr %arrayidx10.sw.sw356, align 4
  %inc.sw.sw373 = add nsw i32 %i.0.sw.sw346, 1
  br label %for.cond.sw.sw345, !llvm.loop !6

ipp.sw.ph.default374:                             ; preds = %ipp.sw.guard.cont342
  %24 = icmp eq i32 %flag3, 0
  br i1 %24, label %ipp.sw.ph.case377, label %ipp.sw.guard.cont378

ipp.sw.ph.case377:                                ; preds = %ipp.sw.ph.default374
  call void @llvm.assume(i1 %24)
  br label %for.cond.sw.sw379

ipp.sw.guard.cont378:                             ; preds = %ipp.sw.ph.default374
  %25 = icmp eq i32 %flag3, 1
  br i1 %25, label %ipp.sw.ph.case400, label %for.cond.sw

for.cond.sw.sw379:                                ; preds = %ipp.sw.ph.case377, %sw.bb.sw.sw383
  %i.0.sw.sw380 = phi i32 [ 0, %ipp.sw.ph.case377 ], [ %inc.sw.sw399, %sw.bb.sw.sw383 ]
  %cmp.sw.sw381 = icmp slt i32 %i.0.sw.sw380, %n
  br i1 %cmp.sw.sw381, label %sw.bb.sw.sw383, label %for.end

sw.bb.sw.sw383:                                   ; preds = %for.cond.sw.sw379
  %idxprom.sw.sw384 = sext i32 %i.0.sw.sw380 to i64
  %arrayidx.sw.sw385 = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw384
  %26 = load i32, ptr %arrayidx.sw.sw385, align 4
  %add.sw.sw386 = add nsw i32 %26, 1
  store i32 %add.sw.sw386, ptr %arrayidx.sw.sw385, align 4
  %idxprom14.sw.sw394 = sext i32 %i.0.sw.sw380 to i64
  %arrayidx15.sw.sw395 = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw.sw394
  %27 = load i32, ptr %arrayidx15.sw.sw395, align 4
  %add16.sw.sw396 = add nsw i32 %27, 3
  store i32 %add16.sw.sw396, ptr %arrayidx15.sw.sw395, align 4
  %inc.sw.sw399 = add nsw i32 %i.0.sw.sw380, 1
  br label %for.cond.sw.sw379, !llvm.loop !6

ipp.sw.ph.case400:                                ; preds = %ipp.sw.guard.cont378
  call void @llvm.assume(i1 %25)
  br label %for.cond.sw.sw402

for.cond.sw.sw402:                                ; preds = %ipp.sw.ph.case400, %sw.bb.sw.sw406
  %i.0.sw.sw403 = phi i32 [ 0, %ipp.sw.ph.case400 ], [ %inc.sw.sw422, %sw.bb.sw.sw406 ]
  %cmp.sw.sw404 = icmp slt i32 %i.0.sw.sw403, %n
  br i1 %cmp.sw.sw404, label %sw.bb.sw.sw406, label %for.end

sw.bb.sw.sw406:                                   ; preds = %for.cond.sw.sw402
  %idxprom.sw.sw407 = sext i32 %i.0.sw.sw403 to i64
  %arrayidx.sw.sw408 = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw.sw407
  %28 = load i32, ptr %arrayidx.sw.sw408, align 4
  %add.sw.sw409 = add nsw i32 %28, 1
  store i32 %add.sw.sw409, ptr %arrayidx.sw.sw408, align 4
  %idxprom18.sw.sw413 = sext i32 %i.0.sw.sw403 to i64
  %arrayidx19.sw.sw414 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw.sw413
  %29 = load i32, ptr %arrayidx19.sw.sw414, align 4
  %sub20.sw.sw415 = sub nsw i32 %29, 3
  store i32 %sub20.sw.sw415, ptr %arrayidx19.sw.sw414, align 4
  %inc.sw.sw422 = add nsw i32 %i.0.sw.sw403, 1
  br label %for.cond.sw.sw402, !llvm.loop !6

for.cond.sw:                                      ; preds = %ipp.sw.guard.cont378, %sw.bb.sw
  %i.0.sw = phi i32 [ %inc.sw, %sw.bb.sw ], [ 0, %ipp.sw.guard.cont378 ]
  %cmp.sw = icmp slt i32 %i.0.sw, %n
  br i1 %cmp.sw, label %sw.bb.sw, label %for.end

sw.bb.sw:                                         ; preds = %for.cond.sw
  %idxprom.sw = sext i32 %i.0.sw to i64
  %arrayidx.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom.sw
  %30 = load i32, ptr %arrayidx.sw, align 4
  %add.sw = add nsw i32 %30, 1
  store i32 %add.sw, ptr %arrayidx.sw, align 4
  %inc.sw = add nsw i32 %i.0.sw, 1
  br label %for.cond.sw, !llvm.loop !6

ipp.sw.ph.case1:                                  ; preds = %ipp.sw.guard.cont
  call void @llvm.assume(i1 %2)
  %31 = icmp eq i32 %flag2, 0
  br i1 %31, label %ipp.sw.ph.case192, label %ipp.sw.guard.cont193

ipp.sw.ph.case192:                                ; preds = %ipp.sw.ph.case1
  call void @llvm.assume(i1 %31)
  %32 = icmp eq i32 %flag3, 0
  br i1 %32, label %ipp.sw.ph.case309, label %ipp.sw.guard.cont310

ipp.sw.guard.cont193:                             ; preds = %ipp.sw.ph.case1
  %33 = icmp eq i32 %flag2, 1
  br i1 %33, label %ipp.sw.ph.case194, label %ipp.sw.ph.default225

ipp.sw.ph.case309:                                ; preds = %ipp.sw.ph.case192
  call void @llvm.assume(i1 %32)
  br label %for.cond.sw3.sw.sw

ipp.sw.guard.cont310:                             ; preds = %ipp.sw.ph.case192
  %34 = icmp eq i32 %flag3, 1
  br i1 %34, label %ipp.sw.ph.case311, label %for.cond.sw3.sw

for.cond.sw3.sw.sw:                               ; preds = %ipp.sw.ph.case309, %sw.bb1.sw7.sw.sw
  %i.0.sw4.sw.sw = phi i32 [ 0, %ipp.sw.ph.case309 ], [ %inc.sw35.sw.sw, %sw.bb1.sw7.sw.sw ]
  %cmp.sw5.sw.sw = icmp slt i32 %i.0.sw4.sw.sw, %n
  br i1 %cmp.sw5.sw.sw, label %sw.bb1.sw7.sw.sw, label %for.end

sw.bb1.sw7.sw.sw:                                 ; preds = %for.cond.sw3.sw.sw
  %idxprom2.sw8.sw.sw = sext i32 %i.0.sw4.sw.sw to i64
  %arrayidx3.sw9.sw.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw.sw
  %35 = load i32, ptr %arrayidx3.sw9.sw.sw, align 4
  %sub.sw10.sw.sw = sub nsw i32 %35, 1
  store i32 %sub.sw10.sw.sw, ptr %arrayidx3.sw9.sw.sw, align 4
  %idxprom5.sw21.sw.sw = sext i32 %i.0.sw4.sw.sw to i64
  %arrayidx6.sw22.sw.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw21.sw.sw
  %36 = load i32, ptr %arrayidx6.sw22.sw.sw, align 4
  %add7.sw23.sw.sw = add nsw i32 %36, 2
  store i32 %add7.sw23.sw.sw, ptr %arrayidx6.sw22.sw.sw, align 4
  %idxprom14.sw30.sw.sw = sext i32 %i.0.sw4.sw.sw to i64
  %arrayidx15.sw31.sw.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw30.sw.sw
  %37 = load i32, ptr %arrayidx15.sw31.sw.sw, align 4
  %add16.sw32.sw.sw = add nsw i32 %37, 3
  store i32 %add16.sw32.sw.sw, ptr %arrayidx15.sw31.sw.sw, align 4
  %inc.sw35.sw.sw = add nsw i32 %i.0.sw4.sw.sw, 1
  br label %for.cond.sw3.sw.sw, !llvm.loop !6

ipp.sw.ph.case311:                                ; preds = %ipp.sw.guard.cont310
  call void @llvm.assume(i1 %34)
  br label %for.cond.sw3.sw.sw313

for.cond.sw3.sw.sw313:                            ; preds = %ipp.sw.ph.case311, %sw.bb1.sw7.sw.sw317
  %i.0.sw4.sw.sw314 = phi i32 [ 0, %ipp.sw.ph.case311 ], [ %inc.sw35.sw.sw337, %sw.bb1.sw7.sw.sw317 ]
  %cmp.sw5.sw.sw315 = icmp slt i32 %i.0.sw4.sw.sw314, %n
  br i1 %cmp.sw5.sw.sw315, label %sw.bb1.sw7.sw.sw317, label %for.end

sw.bb1.sw7.sw.sw317:                              ; preds = %for.cond.sw3.sw.sw313
  %idxprom2.sw8.sw.sw318 = sext i32 %i.0.sw4.sw.sw314 to i64
  %arrayidx3.sw9.sw.sw319 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw.sw318
  %38 = load i32, ptr %arrayidx3.sw9.sw.sw319, align 4
  %sub.sw10.sw.sw320 = sub nsw i32 %38, 1
  store i32 %sub.sw10.sw.sw320, ptr %arrayidx3.sw9.sw.sw319, align 4
  %idxprom5.sw21.sw.sw323 = sext i32 %i.0.sw4.sw.sw314 to i64
  %arrayidx6.sw22.sw.sw324 = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw21.sw.sw323
  %39 = load i32, ptr %arrayidx6.sw22.sw.sw324, align 4
  %add7.sw23.sw.sw325 = add nsw i32 %39, 2
  store i32 %add7.sw23.sw.sw325, ptr %arrayidx6.sw22.sw.sw324, align 4
  %idxprom18.sw26.sw.sw328 = sext i32 %i.0.sw4.sw.sw314 to i64
  %arrayidx19.sw27.sw.sw329 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw26.sw.sw328
  %40 = load i32, ptr %arrayidx19.sw27.sw.sw329, align 4
  %sub20.sw28.sw.sw330 = sub nsw i32 %40, 3
  store i32 %sub20.sw28.sw.sw330, ptr %arrayidx19.sw27.sw.sw329, align 4
  %inc.sw35.sw.sw337 = add nsw i32 %i.0.sw4.sw.sw314, 1
  br label %for.cond.sw3.sw.sw313, !llvm.loop !6

for.cond.sw3.sw:                                  ; preds = %ipp.sw.guard.cont310, %sw.bb1.sw7.sw
  %i.0.sw4.sw = phi i32 [ %inc.sw35.sw, %sw.bb1.sw7.sw ], [ 0, %ipp.sw.guard.cont310 ]
  %cmp.sw5.sw = icmp slt i32 %i.0.sw4.sw, %n
  br i1 %cmp.sw5.sw, label %sw.bb1.sw7.sw, label %for.end

sw.bb1.sw7.sw:                                    ; preds = %for.cond.sw3.sw
  %idxprom2.sw8.sw = sext i32 %i.0.sw4.sw to i64
  %arrayidx3.sw9.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw
  %41 = load i32, ptr %arrayidx3.sw9.sw, align 4
  %sub.sw10.sw = sub nsw i32 %41, 1
  store i32 %sub.sw10.sw, ptr %arrayidx3.sw9.sw, align 4
  %idxprom5.sw21.sw = sext i32 %i.0.sw4.sw to i64
  %arrayidx6.sw22.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw21.sw
  %42 = load i32, ptr %arrayidx6.sw22.sw, align 4
  %add7.sw23.sw = add nsw i32 %42, 2
  store i32 %add7.sw23.sw, ptr %arrayidx6.sw22.sw, align 4
  %inc.sw35.sw = add nsw i32 %i.0.sw4.sw, 1
  br label %for.cond.sw3.sw, !llvm.loop !6

ipp.sw.ph.case194:                                ; preds = %ipp.sw.guard.cont193
  call void @llvm.assume(i1 %33)
  %43 = icmp eq i32 %flag3, 0
  br i1 %43, label %ipp.sw.ph.case277, label %ipp.sw.guard.cont278

ipp.sw.ph.case277:                                ; preds = %ipp.sw.ph.case194
  call void @llvm.assume(i1 %43)
  br label %for.cond.sw3.sw196.sw

ipp.sw.guard.cont278:                             ; preds = %ipp.sw.ph.case194
  %44 = icmp eq i32 %flag3, 1
  br i1 %44, label %ipp.sw.ph.case279, label %for.cond.sw3.sw196

for.cond.sw3.sw196.sw:                            ; preds = %ipp.sw.ph.case277, %sw.bb1.sw7.sw200.sw
  %i.0.sw4.sw197.sw = phi i32 [ 0, %ipp.sw.ph.case277 ], [ %inc.sw35.sw224.sw, %sw.bb1.sw7.sw200.sw ]
  %cmp.sw5.sw198.sw = icmp slt i32 %i.0.sw4.sw197.sw, %n
  br i1 %cmp.sw5.sw198.sw, label %sw.bb1.sw7.sw200.sw, label %for.end

sw.bb1.sw7.sw200.sw:                              ; preds = %for.cond.sw3.sw196.sw
  %idxprom2.sw8.sw201.sw = sext i32 %i.0.sw4.sw197.sw to i64
  %arrayidx3.sw9.sw202.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw201.sw
  %45 = load i32, ptr %arrayidx3.sw9.sw202.sw, align 4
  %sub.sw10.sw203.sw = sub nsw i32 %45, 1
  store i32 %sub.sw10.sw203.sw, ptr %arrayidx3.sw9.sw202.sw, align 4
  %idxprom9.sw17.sw206.sw = sext i32 %i.0.sw4.sw197.sw to i64
  %arrayidx10.sw18.sw207.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw17.sw206.sw
  %46 = load i32, ptr %arrayidx10.sw18.sw207.sw, align 4
  %sub11.sw19.sw208.sw = sub nsw i32 %46, 2
  store i32 %sub11.sw19.sw208.sw, ptr %arrayidx10.sw18.sw207.sw, align 4
  %idxprom14.sw30.sw219.sw = sext i32 %i.0.sw4.sw197.sw to i64
  %arrayidx15.sw31.sw220.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw30.sw219.sw
  %47 = load i32, ptr %arrayidx15.sw31.sw220.sw, align 4
  %add16.sw32.sw221.sw = add nsw i32 %47, 3
  store i32 %add16.sw32.sw221.sw, ptr %arrayidx15.sw31.sw220.sw, align 4
  %inc.sw35.sw224.sw = add nsw i32 %i.0.sw4.sw197.sw, 1
  br label %for.cond.sw3.sw196.sw, !llvm.loop !6

ipp.sw.ph.case279:                                ; preds = %ipp.sw.guard.cont278
  call void @llvm.assume(i1 %44)
  br label %for.cond.sw3.sw196.sw281

for.cond.sw3.sw196.sw281:                         ; preds = %ipp.sw.ph.case279, %sw.bb1.sw7.sw200.sw285
  %i.0.sw4.sw197.sw282 = phi i32 [ 0, %ipp.sw.ph.case279 ], [ %inc.sw35.sw224.sw305, %sw.bb1.sw7.sw200.sw285 ]
  %cmp.sw5.sw198.sw283 = icmp slt i32 %i.0.sw4.sw197.sw282, %n
  br i1 %cmp.sw5.sw198.sw283, label %sw.bb1.sw7.sw200.sw285, label %for.end

sw.bb1.sw7.sw200.sw285:                           ; preds = %for.cond.sw3.sw196.sw281
  %idxprom2.sw8.sw201.sw286 = sext i32 %i.0.sw4.sw197.sw282 to i64
  %arrayidx3.sw9.sw202.sw287 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw201.sw286
  %48 = load i32, ptr %arrayidx3.sw9.sw202.sw287, align 4
  %sub.sw10.sw203.sw288 = sub nsw i32 %48, 1
  store i32 %sub.sw10.sw203.sw288, ptr %arrayidx3.sw9.sw202.sw287, align 4
  %idxprom9.sw17.sw206.sw291 = sext i32 %i.0.sw4.sw197.sw282 to i64
  %arrayidx10.sw18.sw207.sw292 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw17.sw206.sw291
  %49 = load i32, ptr %arrayidx10.sw18.sw207.sw292, align 4
  %sub11.sw19.sw208.sw293 = sub nsw i32 %49, 2
  store i32 %sub11.sw19.sw208.sw293, ptr %arrayidx10.sw18.sw207.sw292, align 4
  %idxprom18.sw26.sw215.sw296 = sext i32 %i.0.sw4.sw197.sw282 to i64
  %arrayidx19.sw27.sw216.sw297 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw26.sw215.sw296
  %50 = load i32, ptr %arrayidx19.sw27.sw216.sw297, align 4
  %sub20.sw28.sw217.sw298 = sub nsw i32 %50, 3
  store i32 %sub20.sw28.sw217.sw298, ptr %arrayidx19.sw27.sw216.sw297, align 4
  %inc.sw35.sw224.sw305 = add nsw i32 %i.0.sw4.sw197.sw282, 1
  br label %for.cond.sw3.sw196.sw281, !llvm.loop !6

for.cond.sw3.sw196:                               ; preds = %ipp.sw.guard.cont278, %sw.bb1.sw7.sw200
  %i.0.sw4.sw197 = phi i32 [ %inc.sw35.sw224, %sw.bb1.sw7.sw200 ], [ 0, %ipp.sw.guard.cont278 ]
  %cmp.sw5.sw198 = icmp slt i32 %i.0.sw4.sw197, %n
  br i1 %cmp.sw5.sw198, label %sw.bb1.sw7.sw200, label %for.end

sw.bb1.sw7.sw200:                                 ; preds = %for.cond.sw3.sw196
  %idxprom2.sw8.sw201 = sext i32 %i.0.sw4.sw197 to i64
  %arrayidx3.sw9.sw202 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw201
  %51 = load i32, ptr %arrayidx3.sw9.sw202, align 4
  %sub.sw10.sw203 = sub nsw i32 %51, 1
  store i32 %sub.sw10.sw203, ptr %arrayidx3.sw9.sw202, align 4
  %idxprom9.sw17.sw206 = sext i32 %i.0.sw4.sw197 to i64
  %arrayidx10.sw18.sw207 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw17.sw206
  %52 = load i32, ptr %arrayidx10.sw18.sw207, align 4
  %sub11.sw19.sw208 = sub nsw i32 %52, 2
  store i32 %sub11.sw19.sw208, ptr %arrayidx10.sw18.sw207, align 4
  %inc.sw35.sw224 = add nsw i32 %i.0.sw4.sw197, 1
  br label %for.cond.sw3.sw196, !llvm.loop !6

ipp.sw.ph.default225:                             ; preds = %ipp.sw.guard.cont193
  %53 = icmp eq i32 %flag3, 0
  br i1 %53, label %ipp.sw.ph.case228, label %ipp.sw.guard.cont229

ipp.sw.ph.case228:                                ; preds = %ipp.sw.ph.default225
  call void @llvm.assume(i1 %53)
  br label %for.cond.sw3.sw230

ipp.sw.guard.cont229:                             ; preds = %ipp.sw.ph.default225
  %54 = icmp eq i32 %flag3, 1
  br i1 %54, label %ipp.sw.ph.case251, label %for.cond.sw3

for.cond.sw3.sw230:                               ; preds = %ipp.sw.ph.case228, %sw.bb1.sw7.sw234
  %i.0.sw4.sw231 = phi i32 [ 0, %ipp.sw.ph.case228 ], [ %inc.sw35.sw250, %sw.bb1.sw7.sw234 ]
  %cmp.sw5.sw232 = icmp slt i32 %i.0.sw4.sw231, %n
  br i1 %cmp.sw5.sw232, label %sw.bb1.sw7.sw234, label %for.end

sw.bb1.sw7.sw234:                                 ; preds = %for.cond.sw3.sw230
  %idxprom2.sw8.sw235 = sext i32 %i.0.sw4.sw231 to i64
  %arrayidx3.sw9.sw236 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw235
  %55 = load i32, ptr %arrayidx3.sw9.sw236, align 4
  %sub.sw10.sw237 = sub nsw i32 %55, 1
  store i32 %sub.sw10.sw237, ptr %arrayidx3.sw9.sw236, align 4
  %idxprom14.sw30.sw245 = sext i32 %i.0.sw4.sw231 to i64
  %arrayidx15.sw31.sw246 = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw30.sw245
  %56 = load i32, ptr %arrayidx15.sw31.sw246, align 4
  %add16.sw32.sw247 = add nsw i32 %56, 3
  store i32 %add16.sw32.sw247, ptr %arrayidx15.sw31.sw246, align 4
  %inc.sw35.sw250 = add nsw i32 %i.0.sw4.sw231, 1
  br label %for.cond.sw3.sw230, !llvm.loop !6

ipp.sw.ph.case251:                                ; preds = %ipp.sw.guard.cont229
  call void @llvm.assume(i1 %54)
  br label %for.cond.sw3.sw253

for.cond.sw3.sw253:                               ; preds = %ipp.sw.ph.case251, %sw.bb1.sw7.sw257
  %i.0.sw4.sw254 = phi i32 [ 0, %ipp.sw.ph.case251 ], [ %inc.sw35.sw273, %sw.bb1.sw7.sw257 ]
  %cmp.sw5.sw255 = icmp slt i32 %i.0.sw4.sw254, %n
  br i1 %cmp.sw5.sw255, label %sw.bb1.sw7.sw257, label %for.end

sw.bb1.sw7.sw257:                                 ; preds = %for.cond.sw3.sw253
  %idxprom2.sw8.sw258 = sext i32 %i.0.sw4.sw254 to i64
  %arrayidx3.sw9.sw259 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8.sw258
  %57 = load i32, ptr %arrayidx3.sw9.sw259, align 4
  %sub.sw10.sw260 = sub nsw i32 %57, 1
  store i32 %sub.sw10.sw260, ptr %arrayidx3.sw9.sw259, align 4
  %idxprom18.sw26.sw264 = sext i32 %i.0.sw4.sw254 to i64
  %arrayidx19.sw27.sw265 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw26.sw264
  %58 = load i32, ptr %arrayidx19.sw27.sw265, align 4
  %sub20.sw28.sw266 = sub nsw i32 %58, 3
  store i32 %sub20.sw28.sw266, ptr %arrayidx19.sw27.sw265, align 4
  %inc.sw35.sw273 = add nsw i32 %i.0.sw4.sw254, 1
  br label %for.cond.sw3.sw253, !llvm.loop !6

for.cond.sw3:                                     ; preds = %ipp.sw.guard.cont229, %sw.bb1.sw7
  %i.0.sw4 = phi i32 [ %inc.sw35, %sw.bb1.sw7 ], [ 0, %ipp.sw.guard.cont229 ]
  %cmp.sw5 = icmp slt i32 %i.0.sw4, %n
  br i1 %cmp.sw5, label %sw.bb1.sw7, label %for.end

sw.bb1.sw7:                                       ; preds = %for.cond.sw3
  %idxprom2.sw8 = sext i32 %i.0.sw4 to i64
  %arrayidx3.sw9 = getelementptr inbounds i32, ptr %A, i64 %idxprom2.sw8
  %59 = load i32, ptr %arrayidx3.sw9, align 4
  %sub.sw10 = sub nsw i32 %59, 1
  store i32 %sub.sw10, ptr %arrayidx3.sw9, align 4
  %inc.sw35 = add nsw i32 %i.0.sw4, 1
  br label %for.cond.sw3, !llvm.loop !6

ipp.sw.ph.default:                                ; preds = %ipp.sw.guard.cont
  %60 = icmp eq i32 %flag2, 0
  br i1 %60, label %ipp.sw.ph.case38, label %ipp.sw.guard.cont39

ipp.sw.ph.case38:                                 ; preds = %ipp.sw.ph.default
  call void @llvm.assume(i1 %60)
  %61 = icmp eq i32 %flag3, 0
  br i1 %61, label %ipp.sw.ph.case164, label %ipp.sw.guard.cont165

ipp.sw.guard.cont39:                              ; preds = %ipp.sw.ph.default
  %62 = icmp eq i32 %flag2, 1
  br i1 %62, label %ipp.sw.ph.case65, label %ipp.sw.ph.default92

ipp.sw.ph.case164:                                ; preds = %ipp.sw.ph.case38
  call void @llvm.assume(i1 %61)
  br label %for.cond.sw40.sw

ipp.sw.guard.cont165:                             ; preds = %ipp.sw.ph.case38
  %63 = icmp eq i32 %flag3, 1
  br i1 %63, label %ipp.sw.ph.case166, label %for.cond.sw40

for.cond.sw40.sw:                                 ; preds = %ipp.sw.ph.case164, %sw.bb4.sw49.sw
  %i.0.sw41.sw = phi i32 [ 0, %ipp.sw.ph.case164 ], [ %inc.sw64.sw, %sw.bb4.sw49.sw ]
  %cmp.sw42.sw = icmp slt i32 %i.0.sw41.sw, %n
  br i1 %cmp.sw42.sw, label %sw.bb4.sw49.sw, label %for.end

sw.bb4.sw49.sw:                                   ; preds = %for.cond.sw40.sw
  %idxprom5.sw50.sw = sext i32 %i.0.sw41.sw to i64
  %arrayidx6.sw51.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw50.sw
  %64 = load i32, ptr %arrayidx6.sw51.sw, align 4
  %add7.sw52.sw = add nsw i32 %64, 2
  store i32 %add7.sw52.sw, ptr %arrayidx6.sw51.sw, align 4
  %idxprom14.sw59.sw = sext i32 %i.0.sw41.sw to i64
  %arrayidx15.sw60.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw59.sw
  %65 = load i32, ptr %arrayidx15.sw60.sw, align 4
  %add16.sw61.sw = add nsw i32 %65, 3
  store i32 %add16.sw61.sw, ptr %arrayidx15.sw60.sw, align 4
  %inc.sw64.sw = add nsw i32 %i.0.sw41.sw, 1
  br label %for.cond.sw40.sw, !llvm.loop !6

ipp.sw.ph.case166:                                ; preds = %ipp.sw.guard.cont165
  call void @llvm.assume(i1 %63)
  br label %for.cond.sw40.sw168

for.cond.sw40.sw168:                              ; preds = %ipp.sw.ph.case166, %sw.bb4.sw49.sw173
  %i.0.sw41.sw169 = phi i32 [ 0, %ipp.sw.ph.case166 ], [ %inc.sw64.sw188, %sw.bb4.sw49.sw173 ]
  %cmp.sw42.sw170 = icmp slt i32 %i.0.sw41.sw169, %n
  br i1 %cmp.sw42.sw170, label %sw.bb4.sw49.sw173, label %for.end

sw.bb4.sw49.sw173:                                ; preds = %for.cond.sw40.sw168
  %idxprom5.sw50.sw174 = sext i32 %i.0.sw41.sw169 to i64
  %arrayidx6.sw51.sw175 = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw50.sw174
  %66 = load i32, ptr %arrayidx6.sw51.sw175, align 4
  %add7.sw52.sw176 = add nsw i32 %66, 2
  store i32 %add7.sw52.sw176, ptr %arrayidx6.sw51.sw175, align 4
  %idxprom18.sw55.sw179 = sext i32 %i.0.sw41.sw169 to i64
  %arrayidx19.sw56.sw180 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw55.sw179
  %67 = load i32, ptr %arrayidx19.sw56.sw180, align 4
  %sub20.sw57.sw181 = sub nsw i32 %67, 3
  store i32 %sub20.sw57.sw181, ptr %arrayidx19.sw56.sw180, align 4
  %inc.sw64.sw188 = add nsw i32 %i.0.sw41.sw169, 1
  br label %for.cond.sw40.sw168, !llvm.loop !6

for.cond.sw40:                                    ; preds = %ipp.sw.guard.cont165, %sw.bb4.sw49
  %i.0.sw41 = phi i32 [ %inc.sw64, %sw.bb4.sw49 ], [ 0, %ipp.sw.guard.cont165 ]
  %cmp.sw42 = icmp slt i32 %i.0.sw41, %n
  br i1 %cmp.sw42, label %sw.bb4.sw49, label %for.end

sw.bb4.sw49:                                      ; preds = %for.cond.sw40
  %idxprom5.sw50 = sext i32 %i.0.sw41 to i64
  %arrayidx6.sw51 = getelementptr inbounds i32, ptr %B, i64 %idxprom5.sw50
  %68 = load i32, ptr %arrayidx6.sw51, align 4
  %add7.sw52 = add nsw i32 %68, 2
  store i32 %add7.sw52, ptr %arrayidx6.sw51, align 4
  %inc.sw64 = add nsw i32 %i.0.sw41, 1
  br label %for.cond.sw40, !llvm.loop !6

ipp.sw.ph.case65:                                 ; preds = %ipp.sw.guard.cont39
  call void @llvm.assume(i1 %62)
  %69 = icmp eq i32 %flag3, 0
  br i1 %69, label %ipp.sw.ph.case136, label %ipp.sw.guard.cont137

ipp.sw.ph.case136:                                ; preds = %ipp.sw.ph.case65
  call void @llvm.assume(i1 %69)
  br label %for.cond.sw67.sw

ipp.sw.guard.cont137:                             ; preds = %ipp.sw.ph.case65
  %70 = icmp eq i32 %flag3, 1
  br i1 %70, label %ipp.sw.ph.case138, label %for.cond.sw67

for.cond.sw67.sw:                                 ; preds = %ipp.sw.ph.case136, %sw.bb8.sw72.sw
  %i.0.sw68.sw = phi i32 [ 0, %ipp.sw.ph.case136 ], [ %inc.sw91.sw, %sw.bb8.sw72.sw ]
  %cmp.sw69.sw = icmp slt i32 %i.0.sw68.sw, %n
  br i1 %cmp.sw69.sw, label %sw.bb8.sw72.sw, label %for.end

sw.bb8.sw72.sw:                                   ; preds = %for.cond.sw67.sw
  %idxprom9.sw73.sw = sext i32 %i.0.sw68.sw to i64
  %arrayidx10.sw74.sw = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw73.sw
  %71 = load i32, ptr %arrayidx10.sw74.sw, align 4
  %sub11.sw75.sw = sub nsw i32 %71, 2
  store i32 %sub11.sw75.sw, ptr %arrayidx10.sw74.sw, align 4
  %idxprom14.sw86.sw = sext i32 %i.0.sw68.sw to i64
  %arrayidx15.sw87.sw = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw86.sw
  %72 = load i32, ptr %arrayidx15.sw87.sw, align 4
  %add16.sw88.sw = add nsw i32 %72, 3
  store i32 %add16.sw88.sw, ptr %arrayidx15.sw87.sw, align 4
  %inc.sw91.sw = add nsw i32 %i.0.sw68.sw, 1
  br label %for.cond.sw67.sw, !llvm.loop !6

ipp.sw.ph.case138:                                ; preds = %ipp.sw.guard.cont137
  call void @llvm.assume(i1 %70)
  br label %for.cond.sw67.sw140

for.cond.sw67.sw140:                              ; preds = %ipp.sw.ph.case138, %sw.bb8.sw72.sw145
  %i.0.sw68.sw141 = phi i32 [ 0, %ipp.sw.ph.case138 ], [ %inc.sw91.sw160, %sw.bb8.sw72.sw145 ]
  %cmp.sw69.sw142 = icmp slt i32 %i.0.sw68.sw141, %n
  br i1 %cmp.sw69.sw142, label %sw.bb8.sw72.sw145, label %for.end

sw.bb8.sw72.sw145:                                ; preds = %for.cond.sw67.sw140
  %idxprom9.sw73.sw146 = sext i32 %i.0.sw68.sw141 to i64
  %arrayidx10.sw74.sw147 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw73.sw146
  %73 = load i32, ptr %arrayidx10.sw74.sw147, align 4
  %sub11.sw75.sw148 = sub nsw i32 %73, 2
  store i32 %sub11.sw75.sw148, ptr %arrayidx10.sw74.sw147, align 4
  %idxprom18.sw82.sw151 = sext i32 %i.0.sw68.sw141 to i64
  %arrayidx19.sw83.sw152 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw82.sw151
  %74 = load i32, ptr %arrayidx19.sw83.sw152, align 4
  %sub20.sw84.sw153 = sub nsw i32 %74, 3
  store i32 %sub20.sw84.sw153, ptr %arrayidx19.sw83.sw152, align 4
  %inc.sw91.sw160 = add nsw i32 %i.0.sw68.sw141, 1
  br label %for.cond.sw67.sw140, !llvm.loop !6

for.cond.sw67:                                    ; preds = %ipp.sw.guard.cont137, %sw.bb8.sw72
  %i.0.sw68 = phi i32 [ %inc.sw91, %sw.bb8.sw72 ], [ 0, %ipp.sw.guard.cont137 ]
  %cmp.sw69 = icmp slt i32 %i.0.sw68, %n
  br i1 %cmp.sw69, label %sw.bb8.sw72, label %for.end

sw.bb8.sw72:                                      ; preds = %for.cond.sw67
  %idxprom9.sw73 = sext i32 %i.0.sw68 to i64
  %arrayidx10.sw74 = getelementptr inbounds i32, ptr %B, i64 %idxprom9.sw73
  %75 = load i32, ptr %arrayidx10.sw74, align 4
  %sub11.sw75 = sub nsw i32 %75, 2
  store i32 %sub11.sw75, ptr %arrayidx10.sw74, align 4
  %inc.sw91 = add nsw i32 %i.0.sw68, 1
  br label %for.cond.sw67, !llvm.loop !6

ipp.sw.ph.default92:                              ; preds = %ipp.sw.guard.cont39
  %76 = icmp eq i32 %flag3, 0
  br i1 %76, label %ipp.sw.ph.case95, label %ipp.sw.guard.cont96

ipp.sw.ph.case95:                                 ; preds = %ipp.sw.ph.default92
  call void @llvm.assume(i1 %76)
  br label %for.cond.sw97

ipp.sw.guard.cont96:                              ; preds = %ipp.sw.ph.default92
  %77 = icmp eq i32 %flag3, 1
  br i1 %77, label %ipp.sw.ph.case114, label %for.cond

for.cond.sw97:                                    ; preds = %ipp.sw.ph.case95, %sw.bb13.sw107
  %i.0.sw98 = phi i32 [ 0, %ipp.sw.ph.case95 ], [ %inc.sw113, %sw.bb13.sw107 ]
  %cmp.sw99 = icmp slt i32 %i.0.sw98, %n
  br i1 %cmp.sw99, label %sw.bb13.sw107, label %for.end

sw.bb13.sw107:                                    ; preds = %for.cond.sw97
  %idxprom14.sw108 = sext i32 %i.0.sw98 to i64
  %arrayidx15.sw109 = getelementptr inbounds i32, ptr %A, i64 %idxprom14.sw108
  %78 = load i32, ptr %arrayidx15.sw109, align 4
  %add16.sw110 = add nsw i32 %78, 3
  store i32 %add16.sw110, ptr %arrayidx15.sw109, align 4
  %inc.sw113 = add nsw i32 %i.0.sw98, 1
  br label %for.cond.sw97, !llvm.loop !6

ipp.sw.ph.case114:                                ; preds = %ipp.sw.guard.cont96
  call void @llvm.assume(i1 %77)
  br label %for.cond.sw116

for.cond.sw116:                                   ; preds = %ipp.sw.ph.case114, %sw.bb17.sw122
  %i.0.sw117 = phi i32 [ 0, %ipp.sw.ph.case114 ], [ %inc.sw132, %sw.bb17.sw122 ]
  %cmp.sw118 = icmp slt i32 %i.0.sw117, %n
  br i1 %cmp.sw118, label %sw.bb17.sw122, label %for.end

sw.bb17.sw122:                                    ; preds = %for.cond.sw116
  %idxprom18.sw123 = sext i32 %i.0.sw117 to i64
  %arrayidx19.sw124 = getelementptr inbounds i32, ptr %B, i64 %idxprom18.sw123
  %79 = load i32, ptr %arrayidx19.sw124, align 4
  %sub20.sw125 = sub nsw i32 %79, 3
  store i32 %sub20.sw125, ptr %arrayidx19.sw124, align 4
  %inc.sw132 = add nsw i32 %i.0.sw117, 1
  br label %for.cond.sw116, !llvm.loop !6

for.cond:                                         ; preds = %ipp.sw.guard.cont96, %for.inc
  %i.0 = phi i32 [ %inc, %for.inc ], [ 0, %ipp.sw.guard.cont96 ]
  %cmp = icmp slt i32 %i.0, %n
  br i1 %cmp, label %for.inc, label %for.end

for.inc:                                          ; preds = %for.cond
  %inc = add nsw i32 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.sw116, %for.cond.sw97, %for.cond.sw67, %for.cond.sw67.sw140, %for.cond.sw67.sw, %for.cond.sw40, %for.cond.sw40.sw168, %for.cond.sw40.sw, %for.cond.sw3, %for.cond.sw3.sw253, %for.cond.sw3.sw230, %for.cond.sw3.sw196, %for.cond.sw3.sw196.sw281, %for.cond.sw3.sw196.sw, %for.cond.sw3.sw, %for.cond.sw3.sw.sw313, %for.cond.sw3.sw.sw, %for.cond.sw, %for.cond.sw.sw402, %for.cond.sw.sw379, %for.cond.sw.sw345, %for.cond.sw.sw345.sw430, %for.cond.sw.sw345.sw, %for.cond.sw.sw, %for.cond.sw.sw.sw462, %for.cond.sw.sw.sw
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
