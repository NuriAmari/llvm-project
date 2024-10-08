; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=powerpc64-unknown-linux-gnu -mcpu=pwr8 -mattr=+vsx | FileCheck -DCOST32=1 %s
; RUN: opt < %s -passes="print<cost-model>" 2>&1 -disable-output -mtriple=powerpc64-unknown-linux-gnu -mcpu=pwr7 -mattr=+vsx | FileCheck -DCOST32=2 %s
target datalayout = "E-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-f128:128:128-v128:128:128-n32:64"
target triple = "powerpc64-unknown-linux-gnu"

define i32 @loads(i32 %arg) {
  ; CHECK: cost of [[COST32]] {{.*}} load
  load <4 x i8>, ptr undef, align 1

  ; CHECK: cost of 1 {{.*}} load
  load <8 x i8>, ptr undef, align 1

  ; CHECK: cost of [[COST32]] {{.*}} load
  load <2 x i16>, ptr undef, align 2

  ; CHECK: cost of 1 {{.*}} load
  load <4 x i16>, ptr undef, align 2

  ret i32 undef
}
