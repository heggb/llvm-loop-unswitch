; ModuleID = '/home/talalaec/llvm-project/llvm-loop-unswitch/build/ir/loop3_input.ll'
source_filename = "/home/talalaec/llvm-project/llvm-loop-unswitch/tests_src/loop3_input.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" }
%"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl" = type { %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data" }
%"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data" = type { ptr, ptr, ptr }

$_ZNKSt6vectorIiSaIiEE4sizeEv = comdat any

$_ZNSt6vectorIiSaIiEE2atEm = comdat any

$_ZNKSt6vectorIiSaIiEE14_M_range_checkEm = comdat any

$_ZNSt6vectorIiSaIiEEixEm = comdat any

@.str = private unnamed_addr constant [74 x i8] c"vector::_M_range_check: __n (which is %zu) >= this->size() (which is %zu)\00", align 1

; Function Attrs: mustprogress noinline uwtable
define dso_local void @_Z3barRSt6vectorIiSaIiEEi(ptr noundef nonnull align 8 dereferenceable(24) %v, i32 noundef %flag) #0 {
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
  %i.0.ipp = phi i64 [ 0, %ipp.unsw.ph.true ], [ %inc.ipp, %if.then.ipp ]
  %call.ipp = call noundef i64 @_ZNKSt6vectorIiSaIiEE4sizeEv(ptr noundef nonnull align 8 dereferenceable(24) %v) #4
  %cmp.ipp = icmp ult i64 %i.0.ipp, %call.ipp
  br i1 %cmp.ipp, label %if.then.ipp, label %for.end

if.then.ipp:                                      ; preds = %for.cond.ipp
  %call1.ipp = call noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt6vectorIiSaIiEE2atEm(ptr noundef nonnull align 8 dereferenceable(24) %v, i64 noundef %i.0.ipp)
  %1 = load i32, ptr %call1.ipp, align 4
  %add.ipp = add nsw i32 %1, 1
  store i32 %add.ipp, ptr %call1.ipp, align 4
  %inc.ipp = add i64 %i.0.ipp, 1
  br label %for.cond.ipp, !llvm.loop !6

for.cond:                                         ; preds = %ipp.unsw.ph.false, %if.else
  %i.0 = phi i64 [ 0, %ipp.unsw.ph.false ], [ %inc, %if.else ]
  %call = call noundef i64 @_ZNKSt6vectorIiSaIiEE4sizeEv(ptr noundef nonnull align 8 dereferenceable(24) %v) #4
  %cmp = icmp ult i64 %i.0, %call
  br i1 %cmp, label %if.else, label %for.end

if.else:                                          ; preds = %for.cond
  %call2 = call noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt6vectorIiSaIiEE2atEm(ptr noundef nonnull align 8 dereferenceable(24) %v, i64 noundef %i.0)
  %2 = load i32, ptr %call2, align 4
  %sub = sub nsw i32 %2, 1
  store i32 %sub, ptr %call2, align 4
  %inc = add i64 %i.0, 1
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond, %for.cond.ipp
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define linkonce_odr dso_local noundef i64 @_ZNKSt6vectorIiSaIiEE4sizeEv(ptr noundef nonnull align 8 dereferenceable(24) %this) #1 comdat align 2 {
entry:
  %_M_impl = getelementptr inbounds nuw %"struct.std::_Vector_base", ptr %this, i32 0, i32 0
  %_M_finish = getelementptr inbounds nuw %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data", ptr %_M_impl, i32 0, i32 1
  %0 = load ptr, ptr %_M_finish, align 8
  %_M_impl2 = getelementptr inbounds nuw %"struct.std::_Vector_base", ptr %this, i32 0, i32 0
  %_M_start = getelementptr inbounds nuw %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data", ptr %_M_impl2, i32 0, i32 0
  %1 = load ptr, ptr %_M_start, align 8
  %sub.ptr.lhs.cast = ptrtoint ptr %0 to i64
  %sub.ptr.rhs.cast = ptrtoint ptr %1 to i64
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast
  %sub.ptr.div = sdiv exact i64 %sub.ptr.sub, 4
  ret i64 %sub.ptr.div
}

; Function Attrs: mustprogress noinline uwtable
define linkonce_odr dso_local noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt6vectorIiSaIiEE2atEm(ptr noundef nonnull align 8 dereferenceable(24) %this, i64 noundef %__n) #0 comdat align 2 {
entry:
  call void @_ZNKSt6vectorIiSaIiEE14_M_range_checkEm(ptr noundef nonnull align 8 dereferenceable(24) %this, i64 noundef %__n)
  %call = call noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt6vectorIiSaIiEEixEm(ptr noundef nonnull align 8 dereferenceable(24) %this, i64 noundef %__n) #4
  ret ptr %call
}

; Function Attrs: mustprogress noinline uwtable
define linkonce_odr dso_local void @_ZNKSt6vectorIiSaIiEE14_M_range_checkEm(ptr noundef nonnull align 8 dereferenceable(24) %this, i64 noundef %__n) #0 comdat align 2 {
entry:
  %call = call noundef i64 @_ZNKSt6vectorIiSaIiEE4sizeEv(ptr noundef nonnull align 8 dereferenceable(24) %this) #4
  %cmp = icmp uge i64 %__n, %call
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call2 = call noundef i64 @_ZNKSt6vectorIiSaIiEE4sizeEv(ptr noundef nonnull align 8 dereferenceable(24) %this) #4
  call void (ptr, ...) @_ZSt24__throw_out_of_range_fmtPKcz(ptr noundef @.str, i64 noundef %__n, i64 noundef %call2) #5
  unreachable

if.end:                                           ; preds = %entry
  ret void
}

; Function Attrs: mustprogress noinline nounwind uwtable
define linkonce_odr dso_local noundef nonnull align 4 dereferenceable(4) ptr @_ZNSt6vectorIiSaIiEEixEm(ptr noundef nonnull align 8 dereferenceable(24) %this, i64 noundef %__n) #1 comdat align 2 {
entry:
  %_M_impl = getelementptr inbounds nuw %"struct.std::_Vector_base", ptr %this, i32 0, i32 0
  %_M_start = getelementptr inbounds nuw %"struct.std::_Vector_base<int, std::allocator<int>>::_Vector_impl_data", ptr %_M_impl, i32 0, i32 0
  %0 = load ptr, ptr %_M_start, align 8
  %add.ptr = getelementptr inbounds nuw i32, ptr %0, i64 %__n
  ret ptr %add.ptr
}

; Function Attrs: noreturn
declare void @_ZSt24__throw_out_of_range_fmtPKcz(ptr noundef, ...) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #3

attributes #0 = { mustprogress noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #4 = { nounwind }
attributes #5 = { noreturn }

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
