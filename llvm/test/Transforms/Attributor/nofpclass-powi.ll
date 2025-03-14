; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 2
; RUN: opt -aa-pipeline=basic-aa -passes=attributor -attributor-manifest-internal -S < %s | FileCheck %s --check-prefixes=CHECK,TUNIT

declare float @llvm.powi.f32.i32(float, i32)
declare float @llvm.powi.f32.i64(float, i64)

declare <2 x float> @llvm.powi.v2f32.v2i32(<2 x float>, <2 x i32>)
declare <4 x float> @llvm.powi.v4f32.i32(<4 x float>, i32)

define float @ret_powi_f32(float %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define float @ret_powi_f32
; CHECK-SAME: (float [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1:[0-9]+]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float [[ARG0]], i32 [[ARG1]]) #[[ATTR6:[0-9]+]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_i64(float %arg0, i64 %arg1) #0 {
; CHECK-LABEL: define float @ret_powi_f32_i64
; CHECK-SAME: (float [[ARG0:%.*]], i64 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i64(float [[ARG0]], i64 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i64(float %arg0, i64 %arg1)
  ret float %call
}

define <2 x float> @ret_powi_v2f32(<2 x float> %arg0, <2 x i32> %arg1) #0 {
; CHECK-LABEL: define <2 x float> @ret_powi_v2f32
; CHECK-SAME: (<2 x float> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> [[ARG0]], <2 x i32> [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret <2 x float> [[CALL]]
;
  %call = call <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> %arg0, <2 x i32> %arg1)
  ret <2 x float> %call
}

define float @ret_powi_f32_odd_constant(float %arg0) #0 {
; CHECK-LABEL: define float @ret_powi_f32_odd_constant
; CHECK-SAME: (float [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float [[ARG0]], i32 noundef 3) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 3)
  ret float %call
}

define float @ret_powi_f32_even_constant(float %arg0) #0 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_powi_f32_even_constant
; CHECK-SAME: (float [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.powi.f32.i32(float [[ARG0]], i32 noundef 4) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 4)
  ret float %call
}

define <2 x float> @ret_powi_v2f32_even_nonsplat(<2 x float> %arg0) #0 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) <2 x float> @ret_powi_v2f32_even_nonsplat
; CHECK-SAME: (<2 x float> [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> [[ARG0]], <2 x i32> noundef <i32 2, i32 4>) #[[ATTR6]]
; CHECK-NEXT:    ret <2 x float> [[CALL]]
;
  %call = call <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> %arg0, <2 x i32> <i32 2, i32 4>)
  ret <2 x float> %call
}

define <2 x float> @ret_powi_v2f32_odd_nonsplat(<2 x float> %arg0) #0 {
; CHECK-LABEL: define <2 x float> @ret_powi_v2f32_odd_nonsplat
; CHECK-SAME: (<2 x float> [[ARG0:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> [[ARG0]], <2 x i32> noundef <i32 3, i32 4>) #[[ATTR6]]
; CHECK-NEXT:    ret <2 x float> [[CALL]]
;
  %call = call <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> %arg0, <2 x i32> <i32 3, i32 4>)
  ret <2 x float> %call
}

define float @ret_powi_f32_masked_to_even(float %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_powi_f32_masked_to_even
; CHECK-SAME: (float [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[KNOWN_EVEN:%.*]] = and i32 [[ARG1]], -2
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.powi.f32.i32(float [[ARG0]], i32 [[KNOWN_EVEN]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %known.even = and i32 %arg1, -2
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %known.even)
  ret float %call
}

define float @ret_powi_f32_masked_to_even_extrabits(float %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_powi_f32_masked_to_even_extrabits
; CHECK-SAME: (float [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[KNOWN_EVEN:%.*]] = and i32 [[ARG1]], -4
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.powi.f32.i32(float [[ARG0]], i32 [[KNOWN_EVEN]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %known.even = and i32 %arg1, -4
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %known.even)
  ret float %call
}

define <2 x float> @ret_powi_v2f32_masked_to_even(<2 x float> %arg0, <2 x i32> %arg1) #0 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) <2 x float> @ret_powi_v2f32_masked_to_even
; CHECK-SAME: (<2 x float> [[ARG0:%.*]], <2 x i32> [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[KNOWN_EVEN:%.*]] = and <2 x i32> [[ARG1]], splat (i32 -2)
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> [[ARG0]], <2 x i32> [[KNOWN_EVEN]]) #[[ATTR6]]
; CHECK-NEXT:    ret <2 x float> [[CALL]]
;
  %known.even = and <2 x i32> %arg1, <i32 -2, i32 -2>
  %call = call <2 x float> @llvm.powi.v2f32.v2i32(<2 x float> %arg0, <2 x i32> %known.even)
  ret <2 x float> %call
}

define float @ret_powi_f32_noneg(float nofpclass(ninf nsub nnorm) %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define float @ret_powi_f32_noneg
; CHECK-SAME: (float nofpclass(ninf nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(ninf nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noneg_nonzero(float nofpclass(ninf nsub nnorm nzero) %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_powi_f32_noneg_nonzero
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.powi.f32.i32(float nofpclass(ninf nzero nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noneg_nozero(float nofpclass(ninf nsub nnorm) %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define float @ret_powi_f32_noneg_nozero
; CHECK-SAME: (float nofpclass(ninf nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(ninf nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_nonzero(float nofpclass(nzero) %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define float @ret_powi_f32_nonzero
; CHECK-SAME: (float nofpclass(nzero) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(nzero) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_nopzero(float nofpclass(pzero) %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define float @ret_powi_f32_nopzero
; CHECK-SAME: (float nofpclass(pzero) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(pzero) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noneg_ftz_daz(float nofpclass(ninf nsub nnorm) %arg0, i32 %arg1) #1 {
; CHECK-LABEL: define float @ret_powi_f32_noneg_ftz_daz
; CHECK-SAME: (float nofpclass(ninf nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR2:[0-9]+]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(ninf nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noneg_nonzero_ftz_daz(float nofpclass(ninf nsub nnorm nzero) %arg0, i32 %arg1) #1 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_powi_f32_noneg_nonzero_ftz_daz
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR2]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.powi.f32.i32(float nofpclass(ninf nzero nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noneg_nonzero_ftpz_dapz(float nofpclass(ninf nsub nnorm nzero) %arg0, i32 %arg1) #2 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_powi_f32_noneg_nonzero_ftpz_dapz
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR3:[0-9]+]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.powi.f32.i32(float nofpclass(ninf nzero nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noninf_nonnorm(float nofpclass(ninf nnorm) %arg0, i32 %arg1) #0 {
; CHECK-LABEL: define float @ret_powi_f32_noninf_nonnorm
; CHECK-SAME: (float nofpclass(ninf nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR1]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(ninf nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noninf_nonnorm_ftz_daz(float nofpclass(ninf nnorm) %arg0, i32 %arg1) #1 {
; CHECK-LABEL: define float @ret_powi_f32_noninf_nonnorm_ftz_daz
; CHECK-SAME: (float nofpclass(ninf nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR2]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(ninf nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noneg_ftz_ieee(float nofpclass(ninf nsub nnorm) %arg0, i32 %arg1) #3 {
; CHECK-LABEL: define float @ret_powi_f32_noneg_ftz_ieee
; CHECK-SAME: (float nofpclass(ninf nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR4:[0-9]+]] {
; CHECK-NEXT:    [[CALL:%.*]] = call float @llvm.powi.f32.i32(float nofpclass(ninf nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define float @ret_powi_f32_noneg_nonzero_ftz_ieee(float nofpclass(ninf nsub nnorm nzero) %arg0, i32 %arg1) #3 {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) float @ret_powi_f32_noneg_nonzero_ftz_ieee
; CHECK-SAME: (float nofpclass(ninf nzero nsub nnorm) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR4]] {
; CHECK-NEXT:    [[CALL:%.*]] = call nofpclass(ninf nzero nsub nnorm) float @llvm.powi.f32.i32(float nofpclass(ninf nzero nsub nnorm) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret float [[CALL]]
;
  %call = call float @llvm.powi.f32.i32(float %arg0, i32 %arg1)
  ret float %call
}

define <4 x float> @powi_v4f32_i32(<4 x float> %arg0, i32 %arg1) {
; CHECK-LABEL: define <4 x float> @powi_v4f32_i32
; CHECK-SAME: (<4 x float> [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR5:[0-9]+]] {
; CHECK-NEXT:    [[POWI:%.*]] = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret <4 x float> [[POWI]]
;
  %powi = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %arg0, i32 %arg1)
  ret <4 x float> %powi
}

define <4 x float> @powi_v4f32_i32_nozero(<4 x float> nofpclass(zero) %arg0, i32 %arg1) {
; CHECK-LABEL: define <4 x float> @powi_v4f32_i32_nozero
; CHECK-SAME: (<4 x float> nofpclass(zero) [[ARG0:%.*]], i32 [[ARG1:%.*]]) #[[ATTR5]] {
; CHECK-NEXT:    [[POWI:%.*]] = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> nofpclass(zero) [[ARG0]], i32 [[ARG1]]) #[[ATTR6]]
; CHECK-NEXT:    ret <4 x float> [[POWI]]
;
  %powi = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %arg0, i32 %arg1)
  ret <4 x float> %powi
}

define <4 x float> @powi_v4f32_i32_constint_even(<4 x float> %arg) {
; CHECK-LABEL: define nofpclass(ninf nzero nsub nnorm) <4 x float> @powi_v4f32_i32_constint_even
; CHECK-SAME: (<4 x float> [[ARG:%.*]]) #[[ATTR5]] {
; CHECK-NEXT:    [[POWI:%.*]] = call nofpclass(ninf nzero nsub nnorm) <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[ARG]], i32 noundef 4) #[[ATTR6]]
; CHECK-NEXT:    ret <4 x float> [[POWI]]
;
  %powi = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %arg, i32 4)
  ret <4 x float> %powi
}

define <4 x float> @powi_v4f32_i32_constint_odd(<4 x float> %arg) {
; CHECK-LABEL: define <4 x float> @powi_v4f32_i32_constint_odd
; CHECK-SAME: (<4 x float> [[ARG:%.*]]) #[[ATTR5]] {
; CHECK-NEXT:    [[POWI:%.*]] = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[ARG]], i32 noundef 3) #[[ATTR6]]
; CHECK-NEXT:    ret <4 x float> [[POWI]]
;
  %powi = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %arg, i32 3)
  ret <4 x float> %powi
}

define <4 x float> @powi_v4f32_i32_regression(<4 x float> %arg) {
; CHECK-LABEL: define nofpclass(nzero) <4 x float> @powi_v4f32_i32_regression
; CHECK-SAME: (<4 x float> [[ARG:%.*]]) #[[ATTR5]] {
; CHECK-NEXT:    [[POWI:%.*]] = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> [[ARG]], i32 noundef 4) #[[ATTR6]]
; CHECK-NEXT:    [[USER:%.*]] = fsub <4 x float> [[POWI]], splat (float 1.000000e+00)
; CHECK-NEXT:    ret <4 x float> [[USER]]
;
  %powi = call <4 x float> @llvm.powi.v4f32.i32(<4 x float> %arg, i32 4)
  %user = fsub <4 x float> %powi, <float 1.000000e+00, float 1.000000e+00, float 1.000000e+00, float 1.000000e+00>
  ret <4 x float> %user
}

attributes #0 = { "denormal-fp-math"="ieee,ieee" }
attributes #1 = { "denormal-fp-math"="preserve-sign,preserve-sign" }
attributes #2 = { "denormal-fp-math"="positive-zero,positive-zero" }
attributes #3 = { "denormal-fp-math"="preserve-sign,ieee" }

;; NOTE: These prefixes are unused and the list is autogenerated. Do not add tests below this line:
; TUNIT: {{.*}}
