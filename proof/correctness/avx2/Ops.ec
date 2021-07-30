require import List Int IntExtra IntDiv CoreMap.

from Jasmin require import JModel JArray JWord_array.

require import Array2p Array4p Array8p Array16p Array32p WArray128p WArray160p.

type t8u32 = W32.t Array8.t.
type t16u16 = W16.t Array16.t.
type t8u16 = W16.t Array8.t.
type t32u8 = W8.t Array32.t.
type t2u64 = W64.t Array2.t.
type t4u64 = W64.t Array4.t.
type t2u128 = W128.t Array2.t.

hint simplify W8.of_intwE @0.

lemma pack2_bits32 (w: W64.t):
   pack2 [w \bits32 0; w \bits32 1] = w.
proof. by apply W2u32.allP. qed.

lemma pack16_bits16 (w: W256.t):
    pack16 [w \bits16 0; w \bits16 1; w \bits16 2; w \bits16 3; w \bits16 4; w \bits16 5; w \bits16 6; w \bits16 7;
    w \bits16 8; w \bits16 9; w \bits16 10; w \bits16 11; w \bits16 12; w \bits16 13; w \bits16 14; w \bits16 15] = w.
proof. by apply W16u16.allP. qed.
    
lemma pack2_bits32_red (w1 w2: W64.t):
   w1 = w2 =>
   pack2 [w1 \bits32 0; w2 \bits32 1] = w1.
proof. by move=> ->; apply pack2_bits32. qed.

lemma pack2_bits8 (w: W16.t):
   pack2 [w \bits8 0; w \bits8 1] = w.
proof. by apply W2u8.allP. qed.

hint simplify pack2_bits32_red @0.

module Ops = {
  proc itruncate_4u64_2u64(t : t4u64) : t2u64 = {
       return Array2.of_list witness [ t.[0]; t.[1] ];
  }

  proc get_128(vv : t4u64 Array4.t, i : int, o : int) : W64.t = {
    return vv.[i].[o];
  }

  proc iVPBROADCAST_4u64(v : W64.t) : t4u64 = {
    var r : t4u64;
    r.[0] <-v;
    r.[1] <-v;
    r.[2] <-v;
    r.[3] <-v;
    return r;
  }

  proc iVPBROADCAST_2u128(v: W128.t) : t2u128 = {
    var r: t2u128;

    r.[0] <-v;
    r.[1] <-v;

    return r;
  }

  proc iVPMULH_256(x y: t16u16) : t16u16 = {
    var r : t16u16;
    r.[0] <- wmulhs x.[0] y.[0];
    r.[1] <- wmulhs x.[1] y.[1];
    r.[2] <- wmulhs x.[2] y.[2];
    r.[3] <- wmulhs x.[3] y.[3];
    r.[4] <- wmulhs x.[4] y.[4];
    r.[5] <- wmulhs x.[5] y.[5];
    r.[6] <- wmulhs x.[6] y.[6];
    r.[7] <- wmulhs x.[7] y.[7];
    r.[8] <- wmulhs x.[8] y.[8];
    r.[9] <- wmulhs x.[9] y.[9];
    r.[10] <- wmulhs x.[10] y.[10];
    r.[11] <- wmulhs x.[11] y.[11];
    r.[12] <- wmulhs x.[12] y.[12];
    r.[13] <- wmulhs x.[13] y.[13];
    r.[14] <- wmulhs x.[14] y.[14];
    r.[15] <- wmulhs x.[15] y.[15];

    return r;
  }

  proc iVPMULL_16u16(x y: t16u16) : t16u16 = {
    var r : t16u16;
    r.[0] <- x.[0] * y.[0];
    r.[1] <- x.[1] * y.[1];
    r.[2] <- x.[2] * y.[2];
    r.[3] <- x.[3] * y.[3];
    r.[4] <- x.[4] * y.[4];
    r.[5] <- x.[5] * y.[5];
    r.[6] <- x.[6] * y.[6];
    r.[7] <- x.[7] * y.[7];
    r.[8] <- x.[8] * y.[8];
    r.[9] <- x.[9] * y.[9];
    r.[10] <- x.[10] * y.[10];
    r.[11] <- x.[11] * y.[11];
    r.[12] <- x.[12] * y.[12];
    r.[13] <- x.[13] * y.[13];
    r.[14] <- x.[14] * y.[14];
    r.[15] <- x.[15] * y.[15];

    return r;
  }
  
  proc iVPMULU_256 (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- mulu64 x.[0] y.[0];
    r.[1] <- mulu64 x.[1] y.[1];
    r.[2] <- mulu64 x.[2] y.[2];
    r.[3] <- mulu64 x.[3] y.[3];
    return r; 
  }

  proc iVPMULHRS_256 (x y: t16u16) : t16u16 = {
    var r : t16u16;

    r.[0] <- round_scalew ((W16.to_sint x.[0]) * (W16.to_sint y.[0]));
    r.[1] <- round_scalew ((W16.to_sint x.[1]) * (W16.to_sint y.[1]));
    r.[2] <- round_scalew ((W16.to_sint x.[2]) * (W16.to_sint y.[2]));
    r.[3] <- round_scalew ((W16.to_sint x.[3]) * (W16.to_sint y.[3]));
    r.[4] <- round_scalew ((W16.to_sint x.[4]) * (W16.to_sint y.[4]));
    r.[5] <- round_scalew ((W16.to_sint x.[5]) * (W16.to_sint y.[5]));
    r.[6] <- round_scalew ((W16.to_sint x.[6]) * (W16.to_sint y.[6]));
    r.[7] <- round_scalew ((W16.to_sint x.[7]) * (W16.to_sint y.[7]));
    r.[8] <- round_scalew ((W16.to_sint x.[8]) * (W16.to_sint y.[8]));
    r.[9] <- round_scalew ((W16.to_sint x.[9]) * (W16.to_sint y.[9]));
    r.[10] <- round_scalew ((W16.to_sint x.[10]) * (W16.to_sint y.[10]));
    r.[11] <- round_scalew ((W16.to_sint x.[11]) * (W16.to_sint y.[11]));
    r.[12] <- round_scalew ((W16.to_sint x.[12]) * (W16.to_sint y.[12]));
    r.[13] <- round_scalew ((W16.to_sint x.[13]) * (W16.to_sint y.[13]));
    r.[14] <- round_scalew ((W16.to_sint x.[14]) * (W16.to_sint y.[14]));
    r.[15] <- round_scalew ((W16.to_sint x.[15]) * (W16.to_sint y.[15]));

    return r;
  }

  proc ivadd64u256(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] + y.[0];
    r.[1] <- x.[1] + y.[1];
    r.[2] <- x.[2] + y.[2];
    r.[3] <- x.[3] + y.[3];
    return r; 
  }

  proc ivadd16u256(x y:t16u16) : t16u16 = {
    var r : t16u16;
    r.[0] <- x.[0] + y.[0];
    r.[1] <- x.[1] + y.[1];
    r.[2] <- x.[2] + y.[2];
    r.[3] <- x.[3] + y.[3];
    r.[4] <- x.[4] + y.[4];
    r.[5] <- x.[5] + y.[5];
    r.[6] <- x.[6] + y.[6];
    r.[7] <- x.[7] + y.[7];
    r.[8] <- x.[8] + y.[8];
    r.[9] <- x.[9] + y.[9];
    r.[10] <- x.[10] + y.[10];
    r.[11] <- x.[11] + y.[11];
    r.[12] <- x.[12] + y.[12];
    r.[13] <- x.[13] + y.[13];
    r.[14] <- x.[14] + y.[14];
    r.[15] <- x.[15] + y.[15];

    return r;
  }

  proc ivsub16u256(x y: t16u16) : t16u16 = {
    var r : t16u16;
    r.[0] <- x.[0] - y.[0];
    r.[1] <- x.[1] - y.[1];
    r.[2] <- x.[2] - y.[2];
    r.[3] <- x.[3] - y.[3];
    r.[4] <- x.[4] - y.[4];
    r.[5] <- x.[5] - y.[5];
    r.[6] <- x.[6] - y.[6];
    r.[7] <- x.[7] - y.[7];
    r.[8] <- x.[8] - y.[8];
    r.[9] <- x.[9] - y.[9];
    r.[10] <- x.[10] - y.[10];
    r.[11] <- x.[11] - y.[11];
    r.[12] <- x.[12] - y.[12];
    r.[13] <- x.[13] - y.[13];
    r.[14] <- x.[14] - y.[14];
    r.[15] <- x.[15] - y.[15];

    return r;
  }
  
  proc iload4u64 (mem:global_mem_t, p:W64.t) : t4u64 = {
    var r : t4u64;
    r.[0] <- loadW64 mem (to_uint p);
    r.[1] <- loadW64 mem (to_uint (p + W64.of_int 8));
    r.[2] <- loadW64 mem (to_uint (p + W64.of_int 16));
    r.[3] <- loadW64 mem (to_uint (p + W64.of_int 24));
    return r;
  }

  proc iload16u16 (mem: global_mem_t, p: W64.t) : t16u16 = {
    var r : t16u16;

    r.[0] <- loadW16 mem (to_uint p);
    r.[1] <- loadW16 mem (to_uint (p + W64.of_int 2));
    r.[2] <- loadW16 mem (to_uint (p + W64.of_int 4));
    r.[3] <- loadW16 mem (to_uint (p + W64.of_int 6));
    r.[4] <- loadW16 mem (to_uint (p + W64.of_int 8));
    r.[5] <- loadW16 mem (to_uint (p + W64.of_int 10));
    r.[6] <- loadW16 mem (to_uint (p + W64.of_int 12));
    r.[7] <- loadW16 mem (to_uint (p + W64.of_int 14));
    r.[8] <- loadW16 mem (to_uint (p + W64.of_int 16));
    r.[9] <- loadW16 mem (to_uint (p + W64.of_int 18));
    r.[10] <- loadW16 mem (to_uint (p + W64.of_int 20));
    r.[11] <- loadW16 mem (to_uint (p + W64.of_int 22));
    r.[12] <- loadW16 mem (to_uint (p + W64.of_int 24));
    r.[13] <- loadW16 mem (to_uint (p + W64.of_int 26));
    r.[14] <- loadW16 mem (to_uint (p + W64.of_int 28));
    r.[15] <- loadW16 mem (to_uint (p + W64.of_int 30));

    return r;
  }

  proc iVPACKUS_8u32(x y: t8u32): t16u16 = {
    var r : t16u16;

    r.[0] <-
      if x.[0] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[0] then (W16.of_int W16.max_uint)
      else x.[0] \bits16 0;
    r.[1] <-
      if x.[1] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[1] then (W16.of_int W16.max_uint)
      else x.[1] \bits16 0;
    r.[2] <-
      if x.[2] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[2] then (W16.of_int W16.max_uint)
      else x.[2] \bits16 0;
    r.[3] <-
      if x.[3] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[3] then (W16.of_int W16.max_uint)
      else x.[3] \bits16 0;
    r.[4] <-
      if y.[0] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[0] then (W16.of_int W16.max_uint)
      else y.[0] \bits16 0;
    r.[5] <-
      if y.[1] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[1] then (W16.of_int W16.max_uint)
      else y.[1] \bits16 0;
    r.[6] <-
      if y.[2] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[2] then (W16.of_int W16.max_uint)
      else y.[2] \bits16 0;
    r.[7] <-
      if y.[3] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[3] then (W16.of_int W16.max_uint)
      else y.[3] \bits16 0;
    r.[8] <-
      if x.[4] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[4] then (W16.of_int W16.max_uint)
      else x.[4] \bits16 0;
    r.[9] <-
      if x.[5] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[5] then (W16.of_int W16.max_uint)
      else x.[5] \bits16 0;
    r.[10] <-
      if x.[6] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[6] then (W16.of_int W16.max_uint)
      else x.[6] \bits16 0;
    r.[11] <-
      if x.[7] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle x.[7] then (W16.of_int W16.max_uint)
      else x.[7] \bits16 0;
    r.[12] <-
      if y.[4] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[4] then (W16.of_int W16.max_uint)
      else y.[4] \bits16 0;
    r.[13] <-
      if y.[5] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[5] then (W16.of_int W16.max_uint)
      else y.[5] \bits16 0;
    r.[14] <-
      if y.[6] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[6] then (W16.of_int W16.max_uint)
      else y.[6] \bits16 0;
    r.[15] <-
      if y.[7] \slt W32.zero then W16.zero
      else if (W32.of_int W16.max_uint) \sle y.[7] then (W16.of_int W16.max_uint)
      else y.[7] \bits16 0;

    return r;
  }

  proc iVPACKUS_16u16(x y: t16u16) : t32u8 = {
    var r: t32u8;

    r.[0] <-
      if x.[0] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[0] then (W8.of_int W8.max_uint)
      else x.[0] \bits8 0;
    r.[1] <-
      if x.[1] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[1] then (W8.of_int W8.max_uint)
      else x.[1] \bits8 0;
    r.[2] <-
      if x.[2] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[2] then (W8.of_int W8.max_uint)
      else x.[2] \bits8 0;
    r.[3] <-
      if x.[3] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[3] then (W8.of_int W8.max_uint)
      else x.[3] \bits8 0;
    r.[4] <-
      if x.[4] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[4] then (W8.of_int W8.max_uint)
      else x.[4] \bits8 0;
    r.[5] <-
      if x.[5] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[5] then (W8.of_int W8.max_uint)
      else x.[5] \bits8 0;
    r.[6] <-
      if x.[6] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[6] then (W8.of_int W8.max_uint)
      else x.[6] \bits8 0;
    r.[7] <-
      if x.[7] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[7] then (W8.of_int W8.max_uint)
      else x.[7] \bits8 0;
    r.[8] <-
      if y.[0] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[0] then (W8.of_int W8.max_uint)
      else y.[0] \bits8 0;
    r.[9] <-
      if y.[1] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[1] then (W8.of_int W8.max_uint)
      else y.[1] \bits8 0;
    r.[10] <-
      if y.[2] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[2] then (W8.of_int W8.max_uint)
      else y.[2] \bits8 0;
    r.[11] <-
      if y.[3] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[3] then (W8.of_int W8.max_uint)
      else y.[3] \bits8 0;
    r.[12] <-
      if y.[4] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[4] then (W8.of_int W8.max_uint)
      else y.[4] \bits8 0;
    r.[13] <-
      if y.[5] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[5] then (W8.of_int W8.max_uint)
      else y.[5] \bits8 0;
    r.[14] <-
      if y.[6] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[6] then (W8.of_int W8.max_uint)
      else y.[6] \bits8 0;
    r.[15] <-
      if y.[7] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[7] then (W8.of_int W8.max_uint)
      else y.[7] \bits8 0;
    r.[16] <-
      if x.[8] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[8] then (W8.of_int W8.max_uint)
      else x.[8] \bits8 0;
    r.[17] <-
      if x.[9] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[9] then (W8.of_int W8.max_uint)
      else x.[9] \bits8 0;
    r.[18] <-
      if x.[10] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[10] then (W8.of_int W8.max_uint)
      else x.[10] \bits8 0;
    r.[19] <-
      if x.[11] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[11] then (W8.of_int W8.max_uint)
      else x.[11] \bits8 0;
    r.[20] <-
      if x.[12] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[12] then (W8.of_int W8.max_uint)
      else x.[12] \bits8 0;
    r.[21] <-
      if x.[13] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[13] then (W8.of_int W8.max_uint)
      else x.[13] \bits8 0;
    r.[22] <-
      if x.[14] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[14] then (W8.of_int W8.max_uint)
      else x.[14] \bits8 0;
    r.[23] <-
      if x.[15] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle x.[15] then (W8.of_int W8.max_uint)
      else x.[15] \bits8 0;
    r.[24] <-
      if y.[8] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[8] then (W8.of_int W8.max_uint)
      else y.[8] \bits8 0;
    r.[25] <-
      if y.[9] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[9] then (W8.of_int W8.max_uint)
      else y.[9] \bits8 0;
    r.[26] <-
      if y.[10] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[10] then (W8.of_int W8.max_uint)
      else y.[10] \bits8 0;
    r.[27] <-
      if y.[11] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[11] then (W8.of_int W8.max_uint)
      else y.[11] \bits8 0;
    r.[28] <-
      if y.[12] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[12] then (W8.of_int W8.max_uint)
      else y.[12] \bits8 0;
    r.[29] <-
      if y.[13] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[13] then (W8.of_int W8.max_uint)
      else y.[13] \bits8 0;
    r.[30] <-
      if y.[14] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[14] then (W8.of_int W8.max_uint)
      else y.[14] \bits8 0;
    r.[31] <-
      if y.[15] \slt W16.zero then W8.zero
      else if (W16.of_int W8.max_uint) \sle y.[15] then (W8.of_int W8.max_uint)
      else y.[15] \bits8 0;

    return r;
  }

  proc iVPACKSS_16u16(x y: t16u16) : t32u8 = {
    var r: t32u8;

    r.[0] <-
      if x.[0] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[0] then (W8.of_int W8.max_sint)
      else x.[0] \bits8 0;
    r.[1] <-
      if x.[1] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[1] then (W8.of_int W8.max_sint)
      else x.[1] \bits8 0;
    r.[2] <-
      if x.[2] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[2] then (W8.of_int W8.max_sint)
      else x.[2] \bits8 0;
    r.[3] <-
      if x.[3] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[3] then (W8.of_int W8.max_sint)
      else x.[3] \bits8 0;
    r.[4] <-
      if x.[4] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[4] then (W8.of_int W8.max_sint)
      else x.[4] \bits8 0;
    r.[5] <-
      if x.[5] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[5] then (W8.of_int W8.max_sint)
      else x.[5] \bits8 0;
    r.[6] <-
      if x.[6] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[6] then (W8.of_int W8.max_sint)
      else x.[6] \bits8 0;
    r.[7] <-
      if x.[7] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[7] then (W8.of_int W8.max_sint)
      else x.[7] \bits8 0;
    r.[8] <-
      if y.[0] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[0] then (W8.of_int W8.max_sint)
      else y.[0] \bits8 0;
    r.[9] <-
      if y.[1] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[1] then (W8.of_int W8.max_sint)
      else y.[1] \bits8 0;
    r.[10] <-
      if y.[2] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[2] then (W8.of_int W8.max_sint)
      else y.[2] \bits8 0;
    r.[11] <-
      if y.[3] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[3] then (W8.of_int W8.max_sint)
      else y.[3] \bits8 0;
    r.[12] <-
      if y.[4] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[4] then (W8.of_int W8.max_sint)
      else y.[4] \bits8 0;
    r.[13] <-
      if y.[5] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[5] then (W8.of_int W8.max_sint)
      else y.[5] \bits8 0;
    r.[14] <-
      if y.[6] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[6] then (W8.of_int W8.max_sint)
      else y.[6] \bits8 0;
    r.[15] <-
      if y.[7] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[7] then (W8.of_int W8.max_sint)
      else y.[7] \bits8 0;
    r.[16] <-
      if x.[8] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[8] then (W8.of_int W8.max_sint)
      else x.[8] \bits8 0;
    r.[17] <-
      if x.[9] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[9] then (W8.of_int W8.max_sint)
      else x.[9] \bits8 0;
    r.[18] <-
      if x.[10] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[10] then (W8.of_int W8.max_sint)
      else x.[10] \bits8 0;
    r.[19] <-
      if x.[11] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[11] then (W8.of_int W8.max_sint)
      else x.[11] \bits8 0;
    r.[20] <-
      if x.[12] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[12] then (W8.of_int W8.max_sint)
      else x.[12] \bits8 0;
    r.[21] <-
      if x.[13] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[13] then (W8.of_int W8.max_sint)
      else x.[13] \bits8 0;
    r.[22] <-
      if x.[14] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[14] then (W8.of_int W8.max_sint)
      else x.[14] \bits8 0;
    r.[23] <-
      if x.[15] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle x.[15] then (W8.of_int W8.max_sint)
      else x.[15] \bits8 0;
    r.[24] <-
      if y.[8] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[8] then (W8.of_int W8.max_sint)
      else y.[8] \bits8 0;
    r.[25] <-
      if y.[9] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[9] then (W8.of_int W8.max_sint)
      else y.[9] \bits8 0;
    r.[26] <-
      if y.[10] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[10] then (W8.of_int W8.max_sint)
      else y.[10] \bits8 0;
    r.[27] <-
      if y.[11] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[11] then (W8.of_int W8.max_sint)
      else y.[11] \bits8 0;
    r.[28] <-
      if y.[12] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[12] then (W8.of_int W8.max_sint)
      else y.[12] \bits8 0;
    r.[29] <-
      if y.[13] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[13] then (W8.of_int W8.max_sint)
      else y.[13] \bits8 0;
    r.[30] <-
      if y.[14] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[14] then (W8.of_int W8.max_sint)
      else y.[14] \bits8 0;
    r.[31] <-
      if y.[15] \slt W16.of_int W8.min_sint then W8.of_int W8.min_sint
      else if (W16.of_int W8.max_sint) \sle y.[15] then (W8.of_int W8.max_sint)
      else y.[15] \bits8 0;

    return r;
  }

  proc iVPERM2I128(x y:t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
    r.[0] <- 
      let n = 0 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[2] else w.[0];
    r.[1] <- 
      let n = 0 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[3] else w.[1];
    r.[2] <- 
      let n = 4 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[2] else w.[0];
    r.[3] <- 
      let n = 4 in
      if p.[n + 3] then W64.of_int 0
      else 
        let w = if p.[n+1] then y else x in
        if p.[n] then w.[3] else w.[1];
      
    return r;
  }

  proc iVPERMQ(x :t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
    r.[0] <- x.[ (to_uint p      ) %% 4 ];
    r.[1] <- x.[ (to_uint p %/  4) %% 4 ];
    r.[2] <- x.[ (to_uint p %/ 16) %% 4 ];
    r.[3] <- x.[ (to_uint p %/ 64) %% 4 ];
    return r;
  }

  proc iVPERMD(x p: t8u32) : t8u32 = {
    var r : t8u32;

    r <- witness;
    r.[0] <- x.[ (to_uint p.[0]) %% 8 ];
    r.[1] <- x.[ (to_uint p.[1]) %% 8 ];
    r.[2] <- x.[ (to_uint p.[2]) %% 8 ];
    r.[3] <- x.[ (to_uint p.[3]) %% 8 ];
    r.[4] <- x.[ (to_uint p.[4]) %% 8 ];
    r.[5] <- x.[ (to_uint p.[5]) %% 8 ];
    r.[6] <- x.[ (to_uint p.[6]) %% 8 ];
    r.[7] <- x.[ (to_uint p.[7]) %% 8 ];

    return r;
  }

  proc iVPSRLDQ_256(x:t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
   
    r.[0] <- 
      if to_uint p = 8 then x.[1]
      else let i = min (to_uint p) 16 in
      if i < 8 then (x.[0] `>>>` 8 * i) `|` (x.[1] `<<<` (64 - 8 * i))
      else x.[1] `>>>` 8 * (i - 8);

    r.[1] <- 
      let i = min (to_uint p) 16 in
      if i < 8 then x.[1] `>>>` 8 * i
      else W64.zero;

    r.[2] <- 
      if to_uint p = 8 then x.[3]
      else let i = min (to_uint p) 16 in
      if i < 8 then (x.[2] `>>>` 8 * i) `|` (x.[3] `<<<` (64 - 8 * i))
      else x.[3] `>>>` 8 * (i - 8);

    r.[3] <- 
      let i = min (to_uint p) 16 in
      if i < 8 then x.[3] `>>>` 8 * i
      else W64.zero;

    return r;
  }

  proc iVPUNPCKH_4u64(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[1];
    r.[1] <- y.[1];
    r.[2] <- x.[3];
    r.[3] <- y.[3];
    return r;
  }

  proc iVPUNPCKL_4u64 (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0];
    r.[1] <- y.[0];
    r.[2] <- x.[2];
    r.[3] <- y.[2];
    return r;
  }

  proc iVEXTRACTI128(x:t4u64, p : W8.t) : t2u64 = {
    var r : t2u64;
    r <- witness;
    r.[0] <- if p.[0] then x.[2] else x.[0];
    r.[1] <- if p.[0] then x.[3] else x.[1];
    return r;
  }  

  proc iVPEXTR_64(x:t2u64, p : W8.t) : W64.t = {
    return x.[to_uint p]; 
  }  

  proc iVPSRA_16u16 (x: t16u16, y: W8.t) : t16u16 = {
    var r : t16u16;
    r.[0] <- x.[0] `|>>` y;
    r.[1] <- x.[1] `|>>` y;
    r.[2] <- x.[2] `|>>` y;
    r.[3] <- x.[3] `|>>` y;
    r.[4] <- x.[4] `|>>` y;
    r.[5] <- x.[5] `|>>` y;
    r.[6] <- x.[6] `|>>` y;
    r.[7] <- x.[7] `|>>` y;
    r.[8] <- x.[8] `|>>` y;
    r.[9] <- x.[9] `|>>` y;
    r.[10] <- x.[10] `|>>` y;
    r.[11] <- x.[11] `|>>` y;
    r.[12] <- x.[12] `|>>` y;
    r.[13] <- x.[13] `|>>` y;
    r.[14] <- x.[14] `|>>` y;
    r.[15] <- x.[15] `|>>` y;

    return r;
  }

  proc iVPSLL_16u16 (x: t16u16, y: W8.t) : t16u16 = {
    var r : t16u16;
    r.[0] <- x.[0] `<<` y;
    r.[1] <- x.[1] `<<` y;
    r.[2] <- x.[2] `<<` y;
    r.[3] <- x.[3] `<<` y;
    r.[4] <- x.[4] `<<` y;
    r.[5] <- x.[5] `<<` y;
    r.[6] <- x.[6] `<<` y;
    r.[7] <- x.[7] `<<` y;
    r.[8] <- x.[8] `<<` y;
    r.[9] <- x.[9] `<<` y;
    r.[10] <- x.[10] `<<` y;
    r.[11] <- x.[11] `<<` y;
    r.[12] <- x.[12] `<<` y;
    r.[13] <- x.[13] `<<` y;
    r.[14] <- x.[14] `<<` y;
    r.[15] <- x.[15] `<<` y;

    return r;
  }

  proc ivshr64u256 (x: t4u64, y: W8.t) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `>>` y;
    r.[1] <- x.[1] `>>` y;
    r.[2] <- x.[2] `>>` y;
    r.[3] <- x.[3] `>>` y;
    return r;
  }

  proc ivshl64u256 (x: t4u64, y: W8.t) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `<<` y;
    r.[1] <- x.[1] `<<` y;
    r.[2] <- x.[2] `<<` y;
    r.[3] <- x.[3] `<<` y;
    return r;
  }



  proc iVPSRLV_4u64 (x: t4u64, y: t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `>>>` W64.to_uint y.[0];
    r.[1] <- x.[1] `>>>` W64.to_uint y.[1];
    r.[2] <- x.[2] `>>>` W64.to_uint y.[2];
    r.[3] <- x.[3] `>>>` W64.to_uint y.[3];
    return r;
  }

  proc iVPSLLV_4u64 (x: t4u64, y:  t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `<<<` W64.to_uint y.[0];
    r.[1] <- x.[1] `<<<` W64.to_uint y.[1];
    r.[2] <- x.[2] `<<<` W64.to_uint y.[2];
    r.[3] <- x.[3] `<<<` W64.to_uint y.[3];
    return r;
  }

  proc iVPSLLV_8u32 (x: t8u32, y:  t8u32) : t8u32 = {
    var r : t8u32;
    r.[0] <- x.[0] `<<<` W32.to_uint y.[0];
    r.[1] <- x.[1] `<<<` W32.to_uint y.[1];
    r.[2] <- x.[2] `<<<` W32.to_uint y.[2];
    r.[3] <- x.[3] `<<<` W32.to_uint y.[3];
    r.[4] <- x.[4] `<<<` W32.to_uint y.[4];
    r.[5] <- x.[5] `<<<` W32.to_uint y.[5];
    r.[6] <- x.[6] `<<<` W32.to_uint y.[6];
    r.[7] <- x.[7] `<<<` W32.to_uint y.[7];
    return r;
  }

  proc iland4u64  (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `&` y.[0];
    r.[1] <- x.[1] `&` y.[1];
    r.[2] <- x.[2] `&` y.[2];
    r.[3] <- x.[3] `&` y.[3];
    return r;
  }

  proc ilor4u64 (x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `|` y.[0];
    r.[1] <- x.[1] `|` y.[1];
    r.[2] <- x.[2] `|` y.[2];
    r.[3] <- x.[3] `|` y.[3];
    return r;
  }

  proc ivpand16u16 (x y: t16u16) : t16u16 = {
    var r : t16u16;

    r.[0] <- x.[0] `&` y.[0];
    r.[1] <- x.[1] `&` y.[1];
    r.[2] <- x.[2] `&` y.[2];
    r.[3] <- x.[3] `&` y.[3];
    r.[4] <- x.[4] `&` y.[4];
    r.[5] <- x.[5] `&` y.[5];
    r.[6] <- x.[6] `&` y.[6];
    r.[7] <- x.[7] `&` y.[7];
    r.[8] <- x.[8] `&` y.[8];
    r.[9] <- x.[9] `&` y.[9];
    r.[10] <- x.[10] `&` y.[10];
    r.[11] <- x.[11] `&` y.[11];
    r.[12] <- x.[12] `&` y.[12];
    r.[13] <- x.[13] `&` y.[13];
    r.[14] <- x.[14] `&` y.[14];
    r.[15] <- x.[15] `&` y.[15];

    return r;
  }

  proc ilandn4u64(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- invw x.[0] `&` y.[0];
    r.[1] <- invw x.[1] `&` y.[1];
    r.[2] <- invw x.[2] `&` y.[2];
    r.[3] <- invw x.[3] `&` y.[3];
    return r; 
  }

  proc ilxor4u64(x y:t4u64) : t4u64 = {
    var r : t4u64;
    r.[0] <- x.[0] `^` y.[0];
    r.[1] <- x.[1] `^` y.[1];
    r.[2] <- x.[2] `^` y.[2];
    r.[3] <- x.[3] `^` y.[3];
    return r; 
  }

  proc ilxor16u16 (x y: t16u16) : t16u16 = {
    var r : t16u16;

    r.[0] <- x.[0] `^` y.[0];
    r.[1] <- x.[1] `^` y.[1];
    r.[2] <- x.[2] `^` y.[2];
    r.[3] <- x.[3] `^` y.[3];
    r.[4] <- x.[4] `^` y.[4];
    r.[5] <- x.[5] `^` y.[5];
    r.[6] <- x.[6] `^` y.[6];
    r.[7] <- x.[7] `^` y.[7];
    r.[8] <- x.[8] `^` y.[8];
    r.[9] <- x.[9] `^` y.[9];
    r.[10] <- x.[10] `^` y.[10];
    r.[11] <- x.[11] `^` y.[11];
    r.[12] <- x.[12] `^` y.[12];
    r.[13] <- x.[13] `^` y.[13];
    r.[14] <- x.[14] `^` y.[14];
    r.[15] <- x.[15] `^` y.[15];

    return r;
  }

  proc iVPBLENDD_256(x y:t4u64, p : W8.t) :  W64.t Array4.t = {
    var r : t4u64;
    r <- witness;
    r.[0] <- 
      if p.[0] = p.[1] then
        let w = if p.[0] then y else x in
        w.[0]
      else
        let w0 = if p.[0] then y else x in
        let w1 = if p.[1] then y else x in
        W2u32.pack2 [w0.[0] \bits32 0; w1.[0] \bits32 1];
    r.[1] <- 
      if p.[2] = p.[3] then
        let w = if p.[2] then y else x in
        w.[1]
      else
        let w0 = if p.[2] then y else x in
        let w1 = if p.[3] then y else x in
        W2u32.pack2 [w0.[1] \bits32 0; w1.[1] \bits32 1];
    r.[2] <- 
      if p.[4] = p.[5] then
        let w = if p.[4] then y else x in
        w.[2]
      else
        let w0 = if p.[4] then y else x in
        let w1 = if p.[5] then y else x in
        W2u32.pack2 [w0.[2] \bits32 0; w1.[2] \bits32 1];
    r.[3] <-
      if p.[6] = p.[7] then
        let w = if p.[6] then y else x in
        w.[3]
      else 
        let w0 = if p.[6] then y else x in
        let w1 = if p.[7] then y else x in
        W2u32.pack2 [w0.[3] \bits32 0; w1.[3] \bits32 1];

    return r;
  }


  proc iVPSHUFD_256 (x :t4u64, p : W8.t) : t4u64 = {
    var r : t4u64;
    r <- witness;
    r.[0] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*0)))%%4 in 
      let p2 = (m %/ (2^(2*1)))%%4 in
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2] 
      else
        pack2 [x.[p1 %/ 2] \bits32 p1 %% 2; x.[p2 %/ 2] \bits32 p2 %% 2];

    r.[1] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*2)))%%4 in 
      let p2 = (m %/ (2^(2*3)))%%4 in 
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2] 
      else
        pack2 [x.[p1 %/ 2] \bits32 p1 %% 2; x.[p2 %/ 2] \bits32 p2 %% 2];

    r.[2] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*0)))%%4 in 
      let p2 = (m %/ (2^(2*1)))%%4 in 
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2 + 2] 
      else
        pack2 [x.[p1 %/ 2 + 2] \bits32 p1 %% 2; x.[p2 %/ 2 + 2] \bits32 p2 %% 2];

    r.[3] <- 
      let m = W8.to_uint p in
      let p1 = (m %/ (2^(2*2)))%%4 in 
      let p2 = (m %/ (2^(2*3)))%%4 in 
      if p1 %/ 2 = p2 %/ 2 /\ p1 %% 2 = 0 /\ p2 %% 2 = 1 then 
        x.[p1 %/ 2 + 2] 
      else
        pack2 [x.[p1 %/ 2 + 2] \bits32 p1 %% 2; x.[p2 %/ 2 + 2] \bits32 p2 %% 2];
    return r;
  }

  proc iVPSHUFB_256 (x: t32u8, m: t32u8): t32u8 = {
    var r: t32u8;

    r.[0] <-
      let i = W8.to_uint m.[0] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[1] <-
      let i = W8.to_uint m.[1] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[2] <-
      let i = W8.to_uint m.[2] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[3] <-
      let i = W8.to_uint m.[3] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[4] <-
      let i = W8.to_uint m.[4] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[5] <-
      let i = W8.to_uint m.[5] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[6] <-
      let i = W8.to_uint m.[6] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[7] <-
      let i = W8.to_uint m.[7] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[8] <-
      let i = W8.to_uint m.[8] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[9] <-
      let i = W8.to_uint m.[9] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[10] <-
      let i = W8.to_uint m.[10] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[11] <-
      let i = W8.to_uint m.[11] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[12] <-
      let i = W8.to_uint m.[12] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[13] <-
      let i = W8.to_uint m.[13] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[14] <-
      let i = W8.to_uint m.[14] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[15] <-
      let i = W8.to_uint m.[15] in
      if 128 <= i then W8.zero else x.[i %% 16];
    r.[16] <-
      let i = W8.to_uint m.[16] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[17] <-
      let i = W8.to_uint m.[17] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[18] <-
      let i = W8.to_uint m.[18] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[19] <-
      let i = W8.to_uint m.[19] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[20] <-
      let i = W8.to_uint m.[20] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[21] <-
      let i = W8.to_uint m.[21] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[22] <-
      let i = W8.to_uint m.[22] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[23] <-
      let i = W8.to_uint m.[23] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[24] <-
      let i = W8.to_uint m.[24] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[25] <-
      let i = W8.to_uint m.[25] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[26] <-
      let i = W8.to_uint m.[26] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[27] <-
      let i = W8.to_uint m.[27] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[28] <-
      let i = W8.to_uint m.[28] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[29] <-
      let i = W8.to_uint m.[29] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[30] <-
      let i = W8.to_uint m.[30] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];
    r.[31] <-
      let i = W8.to_uint m.[31] in
      if 128 <= i then W8.zero else x.[16 + i %% 16];

    return r;
  }
  (* FIXME *)
  proc iVPMOVMSKB_u256_u32(x: t16u16): W32.t = {
    var r: W32.t;

    return r;
  }
}.

type vt2u64 = W128.t.
type vt8u16 = W128.t.
type vt4u64 = W256.t.
type vt8u32 = W256.t.
type vt16u16 = W256.t.
type vt32u8 = W256.t.
type vt2u128 = W256.t.

module OpsV = {
  proc itruncate_4u64_2u64(t : vt4u64) : vt2u64 = {
       return truncateu128 t;
  }

  proc get_128(vv : vt4u64 Array4.t, i : int, o : int) : W64.t = {
    return (get64 (WArray128.init256 (fun i2 => vv.[i2])) (o+4*i));
  }

  proc iVPBROADCAST_4u64(v : W64.t) : vt4u64 = {
    return VPBROADCAST_4u64 v;
  }

  proc iVPBROADCAST_2u128(v : W128.t) : vt2u128 = {
    return VPBROADCAST_2u128 v;
  }

  proc iVPMULH_256 (x y: vt16u16) : vt16u16 = {
    return VPMULH_16u16 x y;
  }

  proc iVPMULL_16u16 (x y: vt16u16) : vt16u16 = {
    return VPMULL_16u16 x y;
  }

  proc iVPMULU_256 (x y:vt4u64) : vt4u64 = {
    return VPMULU_256 x y; 
  }

  proc iVPMULHRS_256(x y: vt16u16): vt16u16 = {
    return VPMULHRSW_256 x y;
  }

  proc ivadd64u256(x y:vt4u64) : vt4u64 = {
    return VPADD_4u64 x y; 
  }

  proc ivadd16u256(x y:vt16u16) : vt16u16 = {
    return VPADD_16u16 x y; 
  }

  proc ivsub16u256(x y: vt16u16) : vt16u16 = {
    return VPSUB_16u16 x y; 
  }

  proc iload4u64 (mem: global_mem_t, p:W64.t) : vt4u64 = {
    return loadW256 mem (to_uint p);  
  }

  proc iload16u16 (mem: global_mem_t, p: W64.t) : vt16u16 = {
    return loadW256 mem (to_uint p);
  }

  proc iVPACKUS_8u32(x y: vt8u32) : vt16u16 = {
    return VPACKUS_8u32 x y;
  }

  proc iVPACKUS_16u16(x y: vt16u16) : vt32u8 = {
    return VPACKUS_16u16 x y;
  }

  proc iVPACKSS_16u16(x y: vt16u16) : vt32u8 = {
    return VPACKSS_16u16 x y;
  }

  proc iVPERM2I128(x y:vt4u64, p : W8.t) : vt4u64 = {
    return VPERM2I128 x y p;
  }

  proc iVPERMQ(x :vt4u64, p : W8.t) : vt4u64 = {
    return VPERMQ x p;
  }

  proc iVPERMD(x p: vt8u32) : vt8u32 = {
    return VPERMD x p;
 }

  proc iVPSRLDQ_256(x:vt4u64, p : W8.t) : vt4u64 = {
    return VPSRLDQ_256 x p;
  }

  proc iVPUNPCKH_4u64(x y:vt4u64) : vt4u64 = {
    return VPUNPCKH_4u64 x y;
  }

  proc iVPUNPCKL_4u64 (x y:vt4u64) : vt4u64 = {
    return VPUNPCKL_4u64 x y;
  }

  proc iVEXTRACTI128(x:vt4u64, p : W8.t) : vt2u64 = {
    return VEXTRACTI128 x p;
  }  

  proc iVPEXTR_64(x:vt2u64, p : W8.t) : W64.t = {
    return VPEXTR_64 x p;
  }

  proc iVPSRA_16u16 (x: vt16u16, y: W8.t) : vt16u16 = {
    return VPSRA_16u16 x y;
  }

  proc iVPSLL_16u16 (x: vt16u16, y: W8.t) : vt16u16 = {
    return VPSLL_16u16 x y;
  }

  proc ivshr64u256 (x: vt4u64, y: W8.t) : vt4u64 = {
    return VPSRL_4u64 x y;
  }

  proc ivshl64u256 (x: vt4u64, y: W8.t) : vt4u64 = {
    return VPSLL_4u64 x y;
  }

  proc iVPSRLV_4u64 (x: vt4u64, y: vt4u64) : vt4u64 = {
    return VPSRLV_4u64 x y;
  }

  proc iVPSLLV_4u64 (x: vt4u64, y: vt4u64) : vt4u64 = {
    return VPSLLV_4u64 x y;
  }

  proc iVPSLLV_8u32 (x: vt8u32, y: vt8u32) : vt8u32 = {
    return VPSLLV_8u32 x y;
  }

  proc ivpand16u16 (x: vt16u16, y: vt16u16) : vt16u16 = {
    return VPAND_256 x y;
  }

  proc iland4u64  (x y: vt4u64) : vt4u64 = {
    return x `&` y;
  }

  proc ilor4u64 (x y: vt4u64) : vt4u64 = {
    return x `|` y;
  }

  proc ilandn4u64(x y: vt4u64) : vt4u64 = {
    return VPANDN_256 x y;
  }

  proc ilxor4u64(x y: vt4u64) : vt4u64 = {
    return x `^` y;
  }

  proc ilxor16u16(x y: vt16u16) : vt16u16 = {
    return x `^` y;
  }

  proc iVPBLENDD_256(x y:vt4u64, p : W8.t) :  vt4u64 = {
    return VPBLENDD_256 x y p;
  }

  proc iVPSHUFD_256 (x :vt4u64, p : W8.t) : vt4u64 = {
    return VPSHUFD_256 x p;
  }

  proc iVPSHUFB_256 (x: vt32u8, m: vt32u8): vt32u8 = {
    return VPSHUFB_256 x m;
  }

  proc iVPMOVMSKB_u256_u32(x: vt16u16): W32.t = {
    return VPMOVMSKB_256 x;
  }
}.

op is2u64 (x : t2u64) (xv: vt2u64)  = xv = W2u64.pack2 [x.[0]; x.[1]].
op is8u16 (x : t8u16) (xv: vt8u16) = xv = W8u16.pack8 [x.[0]; x.[1]; x.[2]; x.[3]; x.[4]; x.[5]; x.[6]; x.[7]].
op is4u64 (x : t4u64) (xv: vt4u64) = xv = W4u64.pack4 [x.[0]; x.[1]; x.[2]; x.[3]].
op is16u16 (x : t16u16) (xv: vt16u16) = xv = W16u16.pack16 [x.[0]; x.[1]; x.[2]; x.[3]; x.[4]; x.[5]; x.[6]; x.[7];
  x.[8]; x.[9]; x.[10]; x.[11]; x.[12]; x.[13]; x.[14]; x.[15]].
op is8u32 (x: t8u32) (xv: vt8u32) = xv = W8u32.pack8 [x.[0]; x.[1]; x.[2]; x.[3]; x.[4]; x.[5]; x.[6]; x.[7]].
op is2u128 (x : t2u128) (xv: vt2u128) = xv = W2u128.pack2 [x.[0]; x.[1]].
op is32u8 (x : t32u8) (xv: vt32u8) = xv = W32u8.pack32 [x.[0]; x.[1]; x.[2]; x.[3]; x.[4]; x.[5]; x.[6]; x.[7];
                                                        x.[8]; x.[9]; x.[10]; x.[11]; x.[12]; x.[13]; x.[14]; x.[15];
                                                        x.[16]; x.[17]; x.[18]; x.[19]; x.[20]; x.[21]; x.[22]; x.[23];
                                                        x.[24]; x.[25]; x.[26]; x.[27]; x.[28]; x.[29]; x.[30]; x.[31]].

(* TODO *)
lemma ivadd16u256_spec x_ y_ : hoare[Ops.ivadd16u256 : x = x_ /\ y = y_ ==> forall i, res.[i] = x_.[i] + y_.[i]].
admitted.

equiv eq_itruncate_4u64_2u64 : Ops.itruncate_4u64_2u64 ~ OpsV.itruncate_4u64_2u64 : is4u64 t{1} t{2} ==> is2u64 res{1} res{2}.
proof.
  proc; skip => &1 &2; rewrite /is2u64 /is4u64 => -> /=.
  apply (Core.can_inj _ _ W128.to_uintK).
  rewrite to_uint_truncateu128.
  rewrite - (W128.to_uint_small (to_uint (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]) %% W128.modulus)).
  + by apply modz_cmp.
  congr; apply W128.wordP => i hi.
  rewrite W128.of_intwE hi W2u64.pack2wE 1:// /=.
  rewrite /int_bit /= modz_mod.
  have /= -> := modz_pow2_div 128 i; 1:smt().
  rewrite (modz_dvd_pow 1 (128 - i) _ 2) 1:/# /=.
  have : (to_uint (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]) %/ (IntExtra.(^) 2 i) %% 2 <> 0) = 
            (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]).[i].
  + rewrite -{2}(W256.to_uintK (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]])) W256.of_intwE /int_bit (modz_small _ W256.modulus) 2:/#.
    by have /= := W256.to_uint_cmp  (pack4 [t{1}.[0]; t{1}.[1]; t{1}.[2]; t{1}.[3]]);rewrite /(`|_|).
  rewrite W4u64.pack4wE 1:/#.
  case: (i < 64) => hi'.
  admit.
  (* FIXME
  + by rewrite divz_small 1:/#.
  *)
  have -> // : i %/ 64 = 1.
  have -> : i = (i -64) + 1 * 64 by done.
  rewrite divzMDr 1://; smt(divz_small).
  admit.
qed.

op is4u64_4 (x:t4u64 Array4.t) (xv:vt4u64 Array4.t) = 
  xv = Array4.init (fun i => W4u64.pack4 [x.[i].[0]; x.[i].[1]; x.[i].[2]; x.[i].[3]]).

lemma get8_pack4u64 ws j: 
  W4u64.pack4_t ws \bits8 j = 
    if 0 <= j < 32 then ws.[j %/ 8] \bits8 (j %% 8) else W8.zero.
proof.
  rewrite pack4E W8.wordP => i hi.
  rewrite bits8E /= initE hi /= initE.
  have -> /= : (0 <= j * 8 + i < 256) <=> (0 <= j < 32) by smt().
  case : (0 <= j < 32) => hj //=.
  rewrite bits8E /= initE.
  have -> : (j * 8 + i) %/ 64 = j %/ 8.
  + rewrite {1}(divz_eq j 8) mulzDl mulzA /= -addzA divzMDl //.
    by rewrite (divz_small _ 64) //; smt (modz_cmp).
  rewrite hi /=;congr.
  rewrite {1}(divz_eq j 8) mulzDl mulzA /= -addzA modzMDl modz_small //; smt (modz_cmp).
qed.

equiv eq_get_128 : Ops.get_128 ~ OpsV.get_128 : is4u64_4 vv{1} vv{2} /\ ={i,o} /\ 0 <= i{1} < 4 /\ 0 <= o{1} < 4 ==> ={res}.
proof.
  proc;skip;rewrite /is4u64_4 => /> &1 &2 h1 h2 h3 h4.
  rewrite /init256 get64E -(W8u8.unpack8K vv{1}.[i{2}].[o{2}]);congr.
  apply W8u8.Pack.packP => j hj.
  (* FIXME
  rewrite W8u8.Pack.initiE 1:// initiE 1:// /= initiE 1:/# /=.
  have -> : (8 * (o{2} + 4 * i{2}) + j) = (o{2} * 8 + j) + i{2} * 32 by ring.
  have ? : 0 <= o{2} * 8 + j < `|32| by smt().
  rewrite modzMDr divzMDr 1:// divz_small 1:// modz_small 1:// /=.
  rewrite Array4.initiE 1:// /= get8_pack4u64.
  have /= <- := W4u64.Pack.init_of_list (fun j => vv{1}.[i{2}].[j]).
  rewrite divzMDl 1:// divz_small 1:// modzMDl /= initiE 1:// modz_small 1:// /#.
  *)
  admit.
qed.

equiv eq_ivadd64u256: Ops.ivadd64u256 ~ OpsV.ivadd64u256 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp;skip;rewrite /is4u64 /VPADD_4u64. qed.

equiv eq_iVPMULH_256 : Ops.iVPMULH_256 ~ OpsV.iVPMULH_256: is16u16 x{1} x{2} /\ is16u16 y{1} y{2} ==> is16u16 res{1} res{2}.
proof. proc; by wp; skip; rewrite /is16u16 /VPMULH. qed.

equiv eq_iVPMULL_16u16 : Ops.iVPMULL_16u16 ~ OpsV.iVPMULL_16u16: is16u16 x{1} x{2} /\ is16u16 y{1} y{2} ==> is16u16 res{1} res{2}.
proof. proc; by wp; skip; rewrite /is16u16 /VPMULH. qed.

equiv eq_iVPMULU_256 : Ops.iVPMULU_256 ~ OpsV.iVPMULU_256 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp;skip;rewrite /is4u64 => /> &1; rewrite /VPMULU_256. qed.

equiv eq_ivadd16u256: Ops.ivadd16u256 ~ OpsV.ivadd16u256 : is16u16 x{1} x{2} /\ is16u16 y{1} y{2} ==> is16u16 res{1} res{2}.
proof. by proc;wp;skip;rewrite /is16u16 /VPADD_16u16. qed.

equiv eq_ivsub16u256: Ops.ivsub16u256 ~ OpsV.ivsub16u256 : is16u16 x{1} x{2} /\ is16u16 y{1} y{2} ==> is16u16 res{1} res{2}.
proof. by proc;wp;skip;rewrite /is16u16 /VPSUB_16u16. qed.

equiv eq_iVPBROADCAST_2u128 : Ops.iVPBROADCAST_2u128 ~ OpsV.iVPBROADCAST_2u128 : ={v} ==> is2u128 res{1} res{2}.
proof.
  proc; wp; skip; rewrite /is2u128 /VPBROADCAST_2u128.
  admit. (* FIXME *)
qed.

equiv eq_iVPBROADCAST_4u64 : Ops.iVPBROADCAST_4u64 ~ OpsV.iVPBROADCAST_4u64 : ={v} ==> is4u64 res{1} res{2}.
proof. proc => /=. wp. skip. rewrite /is4u64 /VPBROADCAST_4u64. admit. (* FIXME *) qed.

equiv eq_iload4u64: Ops.iload4u64 ~ OpsV.iload4u64 : ={mem, p} /\ to_uint p{1} + 32 <= W64.modulus ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &2 hp.
  rewrite /loadW256 -(W32u8.unpack8K (W4u64.pack4 _));congr.
  apply W32u8.Pack.packP => j hj. 
  rewrite initiE 1:// W32u8.get_unpack8 1:// /= get8_pack4u64 hj /=.
  (* FIXME
  have /= <- := W4u64.Pack.init_of_list (fun j => loadW64 mem{2} (to_uint (p{2} + W64.of_int (8 * j)))).
  have ? : 0 <= j %/ 8 < 4 by rewrite ltz_divLR // lez_divRL.
  have ? := modz_cmp j 8.
  rewrite initiE 1:// /loadW64 /= pack8bE 1:// initiE 1:// /=. 
  have heq : to_uint (W64.of_int (8 * (j %/ 8))) = 8 * (j %/ 8).
  + by rewrite of_uintK modz_small 2:// /= /#.
  rewrite to_uintD_small heq 1:/#; smt (edivzP).
  *)
  admit.
qed.

equiv eq_iVPACKUS_8u32 : Ops.iVPACKUS_8u32 ~ OpsV.iVPACKUS_8u32 : is8u32 x{1} x{2} /\ is8u32 y{1} y{2} ==> is16u16 res{1} res{2}.
proof. proc; wp; skip; rewrite /is8u32 /VPACKUS_8u32 /packus_4u32 //=. qed.

equiv eq_iVPERM2I128 : Ops.iVPERM2I128 ~ OpsV.iVPERM2I128 : 
  is4u64 x{1} x{2} /\ is4u64 y{1} y{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2; cbv delta.
  rewrite -(W8.to_uintK' p{2}) !of_intwE /=.
  apply W2u128.allP => /=.
  case: (W8.int_bit (to_uint p{2}) 3) => ?.
  + split; 1: by apply W2u64.allP; cbv delta.
    case: (W8.int_bit (to_uint p{2}) 7) => ?; 1: by apply W2u64.allP; cbv delta.
    by case: (W8.int_bit (to_uint p{2}) 5) => ?; case: (W8.int_bit (to_uint p{2}) 4).
  split.
  + by case: (W8.int_bit (to_uint p{2}) 1) => ?; case: (W8.int_bit (to_uint p{2}) 0). 
  case: (W8.int_bit (to_uint p{2}) 7) => ?;  1: by apply W2u64.allP; cbv delta.
  by case: (W8.int_bit (to_uint p{2}) 5) => ?; case: (W8.int_bit (to_uint p{2}) 4).
qed.

lemma pack4_bits64 (x:t4u64) (i:int): 0 <= i < 4 =>
    pack4 [x.[0]; x.[1]; x.[2]; x.[3]] \bits64 i = x.[i].
proof. admit. (*by have /= <- [#|] -> := mema_iota 0 4.*) qed.

equiv eq_iVPERMQ : Ops.iVPERMQ ~ OpsV.iVPERMQ : is4u64 x{1} x{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2.
  by rewrite /VPERMQ /= !pack4_bits64 ?modz_cmp.
qed.

lemma lsr_2u64 (w1 w2:W64.t) (x:int) : 0 <= x <= 64 => 
  pack2 [w1; w2] `>>>` x = pack2 [(w1 `>>>` x) `|` (w2 `<<<` 64 - x); w2 `>>>` x].
proof.
  move=> hx;apply W128.wordP => i hi.
  rewrite pack2wE 1://.
  rewrite W128.shrwE hi /=.
  case: (i < 64) => hi1.
  + have [-> ->] /=: i %/ 64 = 0 /\ i %% 64 = i by smt(edivzP). 
    rewrite pack2wE 1:/#.
    have -> : 0 <= i < 64 by smt().
    case: (i + x < 64) => hix.
    + have [-> ->] /= : (i + x) %/ 64 = 0 /\ (i + x) %% 64 = i + x by smt(edivzP).
      by rewrite (W64.get_out w2) 1:/#.
    have [-> ->] /= : (i + x) %/ 64 = 1 /\ (i + x) %% 64 = i - (64 - x) by smt(edivzP).
    by rewrite (W64.get_out w1) 1:/#.
  have [-> ->] /= : i %/ 64 = 1 /\ i %% 64 = i - 64 by smt(edivzP). 
  case (i + x < 128) => hix;last by rewrite W128.get_out 1:/# W64.get_out 1:/#.  
  rewrite pack2wE 1:/#.
  have -> /= : 0 <= i - 64 < 64 by smt().
  by have [-> ->] : (i + x) %/ 64 = 1 /\ (i + x) %% 64 = i - 64 + x by smt(edivzP).
qed.

lemma lsr_2u64_64 (w1 w2:W64.t) (x:int) : 64 <= x <= 128 => 
  pack2 [w1; w2] `>>>` x = pack2 [(w2 `>>>` (x - 64)); W64.zero].
proof.
  move=> hx;apply W128.wordP => i hi.
  rewrite pack2wE 1://.
  rewrite W128.shrwE hi /=.
  case: (i < 64) => hi1.
  + have [-> ->] /=: i %/ 64 = 0 /\ i %% 64 = i by smt(edivzP).
    case: (i + x < 128) => ?.
    + rewrite pack2wE 1:/#.
      by have -> /= /# : (i + x) %/ 64 = 1 by smt().
    by rewrite W128.get_out 1:/# W64.get_out 1:/#.
  have [-> ->] /= : i %/ 64 = 1 /\ i %% 64 = i - 64 by smt(edivzP). 
  by rewrite W128.get_out 1:/#.
qed.

lemma lsr_0 (w:W64.t) : w `<<<` 0 = w.
proof. by apply W64.wordP => i hi; rewrite W64.shlwE hi. qed.

equiv eq_iVPSRLDQ_256: Ops.iVPSRLDQ_256 ~ OpsV.iVPSRLDQ_256 : 
  is4u64 x{1} x{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2; cbv delta.
  case: (to_uint p{2} = 8) => [-> | ?] /=.
  + by rewrite !lsr_2u64 //= !lsr_0.
  pose i := if to_uint p{2} < 16 then to_uint p{2} else 16.
  case: (i < 8) => ?.
  + rewrite !lsr_2u64 //=; smt (W8.to_uint_cmp).
  by rewrite !lsr_2u64_64 1,2:/# /= /#.
qed.

equiv eq_iVPUNPCKH_4u64: Ops.iVPUNPCKH_4u64 ~ OpsV.iVPUNPCKH_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVPUNPCKL_4u64: Ops.iVPUNPCKL_4u64 ~ OpsV.iVPUNPCKL_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVEXTRACTI128: Ops.iVEXTRACTI128 ~ OpsV.iVEXTRACTI128 : 
  is4u64 x{1} x{2} /\ ={p} ==> is2u64 res{1} res{2}.
proof.
  proc; wp; skip;rewrite /is4u64 /is2u64 /VEXTRACTI128 => /> &1 &2.
  by case: (p{2}.[0]) => ?; cbv delta.
qed.
 
equiv eq_iVPEXTR_64: Ops.iVPEXTR_64 ~ OpsV.iVPEXTR_64 : is2u64 x{1} x{2} /\ ={p} /\ (p{1} = W8.of_int 0 \/ p{2} = W8.of_int 1)==> res{1} = res{2}.
proof. by proc; skip; rewrite /is2u64 /VPEXTR_64 => /> &1 &2 [] -> /=. qed.

equiv eq_iVPSLL_16u16: Ops.iVPSLL_16u16 ~ OpsV.iVPSLL_16u16: is16u16 x{1} x{2} /\ ={y} ==> is16u16 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is16u16 /VPSLL_16u16. qed.

equiv eq_iVPSRA_16u16: Ops.iVPSRA_16u16 ~ OpsV.iVPSRA_16u16: is16u16 x{1} x{2} /\ ={y} ==> is16u16 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is16u16 /VPSRA_16u16. qed.

equiv eq_ivshr64u256: Ops.ivshr64u256 ~ OpsV.ivshr64u256 : is4u64 x{1} x{2} /\ ={y} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 /VPSRL_4u64. qed.

equiv eq_ivshl64u256: Ops.ivshl64u256 ~ OpsV.ivshl64u256 : is4u64 x{1} x{2} /\ ={y} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 /VPSLL_4u64. qed.

equiv eq_ivpand16u16: Ops.ivpand16u16 ~ OpsV.ivpand16u16 : is16u16 x{1} x{2} /\ is16u16 y{1} y{2} ==> is16u16 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is16u16. qed.

equiv eq_iland4u64: Ops.iland4u64 ~ OpsV.iland4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64. qed.

equiv eq_ilor4u64: Ops.ilor4u64 ~ OpsV.ilor4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64. qed.

equiv eq_ilandn4u64 : Ops.ilandn4u64 ~ OpsV.ilandn4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_ilxor4u64: Ops.ilxor4u64 ~ OpsV.ilxor4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc; wp; skip; rewrite /is4u64. qed.

equiv eq_iVPSRLV_4u64 : Ops.iVPSRLV_4u64 ~ OpsV.iVPSRLV_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVPSLLV_4u64 : Ops.iVPSLLV_4u64 ~ OpsV.iVPSLLV_4u64 : is4u64 x{1} x{2} /\ is4u64 y{1} y{2} ==> is4u64 res{1} res{2}.
proof. by proc;wp; skip; rewrite /is4u64 => />; cbv delta. qed.

equiv eq_iVPBLENDD_256 : Ops.iVPBLENDD_256 ~ OpsV.iVPBLENDD_256 : 
  is4u64 x{1} x{2} /\ is4u64 y{1} y{2} /\ ={p}
  ==> 
  is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 /VPBLENDD_256 => /> &1 &2 /=.
  apply W8u32.allP => /=.
  split; 1: by case: (p{2}.[0] = p{2}.[1]); case: (p{2}.[0]).
  split; 1: by case: (p{2}.[0] = p{2}.[1]) => [->|]; case: (p{2}.[1]).
  split; 1: by case: (p{2}.[2] = p{2}.[3]); case: (p{2}.[2]).
  split; 1: by case: (p{2}.[2] = p{2}.[3]) => [->|];case: (p{2}.[3]).
  split; 1: by case: ( p{2}.[4] = p{2}.[5]); case: (p{2}.[4]).
  split; 1: by case: ( p{2}.[4] = p{2}.[5]) => [->|]; case: (p{2}.[5]).
  split; 1: by case: (p{2}.[6] = p{2}.[7]); case: (p{2}.[6]).
  by case: (p{2}.[6] = p{2}.[7]) => [->|]; case: (p{2}.[7]).
qed.

equiv eq_iVPSHUFD_256 : Ops.iVPSHUFD_256 ~ OpsV.iVPSHUFD_256 : 
  is4u64 x{1} x{2} /\ ={p} ==> is4u64 res{1} res{2}.
proof. 
  proc; wp; skip; rewrite /is4u64 => /> &1 &2; apply W8u32.allP; cbv delta.
  have heq0 : forall (w: t4u64) i, 0 <= i < 2 => (W2u64.Pack.of_list [w.[0]; w.[1]]).[i] = w.[i].
  + admit. (* FIXME: by move=> w i /(mema_iota 0 2) /= [#|] -> /=.*)
  have heq1 : forall (w: t4u64) i, 0 <= i < 2 => (W2u64.Pack.of_list [w.[2]; w.[3]]).[i] = w.[i+2].
  + admit. (* FIXME: by move=> w i /(mema_iota 0 2) /= [#|] -> /=.*)
  have hmod : forall x, 0 <= x %%4 %/2 < 2 by smt().
  do !(rewrite bits32_W2u64_red 1:modz_cmp 1:// heq0 1:hmod /=).
  do !(rewrite bits32_W2u64_red 1:modz_cmp 1:// heq1 1:hmod /=).
  split.
  + admit.
  (* FIXME
  by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [ [# -> ->] |]. *)
  split.
  + admit.
  (* FIXME
  by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [ [# -> _ ->] |].*)
  split.
  + admit.
  (* FIXME
  by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
         to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> ->] |]. *)
  split.
  + admit.
  (* FIXME
  by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
         to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> _ ->] |]. *)
  split.
  + admit.
  (* FIXME
  by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [[# -> ->]|]. *)
  split.
  + admit.
  (* FIXME
  by case: (to_uint p{2} %% 4 %/ 2 = to_uint p{2} %/ 4 %% 4 %/ 2 /\
         to_uint p{2} %% 4 %% 2 = 0 /\ to_uint p{2} %/ 4 %% 4 %% 2 = 1) => [[# -> _ ->]|]. *)
  split.
  + admit.
  (* FIXME
  by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
         to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> ->]|]. *)
  admit.
  (* FIXME
  by case: (to_uint p{2} %/ 16 %% 4 %/ 2 = to_uint p{2} %/ 64 %% 4 %/ 2 /\
       to_uint p{2} %/ 16 %% 4 %% 2 = 0 /\ to_uint p{2} %/ 64 %% 4 %% 2 = 1) => [[# -> _ ->]|].*)
qed.

equiv eq_iVPSHUFB_256 : Ops.iVPSHUFB_256 ~ OpsV.iVPSHUFB_256:
  is32u8 x{1} x{2} /\ is32u8 m{1} m{2} ==> is32u8 res{1} res{2}.
proof.
proc; wp; skip. rewrite /is32u8 /VPSHUFB_256 /VPSHUFB_128 /VPSHUFB_128_B. auto => />.
admit.
qed.
