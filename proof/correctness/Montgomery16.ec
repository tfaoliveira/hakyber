require import AllCore IntDiv Ring StdOrder.
import Ring.IntID IntOrder.


(* @JBA: MOVE THIS *)

lemma nosmt modzB_eq0 (x y m:int):
 0 < m => (x-y) %% m = 0 =>
 x%%m = y%%m.
proof.
move=> Hm.
have ->: (x-y) %% m = (x%%m - y%%m) %% m.
 rewrite modzDml eq_sym.
 by rewrite -modzDmr modzNm modzDmr.
have ?: 0 <= x%%m < m by smt().
have ?: 0 <= y%%m < m by smt().
rewrite -dvdzE; move=>/dvdzP [k].
case: (k < 0); smt().
qed.

(* JWord (here instantiated on W16) *)
from Jasmin require import JWord.
import W16.

lemma nosmt to_sint_mod x:
 W16.to_sint x %% W16.modulus = to_uint x.
proof.
rewrite /to_sint /smod.
case: (2 ^ (16 - 1) <= to_uint x) => C.
 rewrite -modzDm -modzNm modzz /= modz_mod.
 rewrite modz_small //.
 by apply JUtils.bound_abs; apply to_uint_cmp.
rewrite modz_small //.
by apply JUtils.bound_abs; apply to_uint_cmp.
qed.

lemma nosmt smod_small (x: int):
 -2^(16-1) <= x < 2^(16-1) => 
 W16.smod (x %% W16.modulus) = x.
proof.
move => [/= Hl Hh]. 
rewrite /smod; case: (x < 0) => C.
 by have ->/#: 2 ^ (16 - 1) <= x %% W16.modulus by smt().
by have ->/#: ! 2 ^ (16 - 1) <= x %% W16.modulus by smt().
qed.

lemma nosmt modzM_sint (x y: W16.t):
 (to_sint x * to_sint y) %% W16.modulus
 = (to_uint x * to_uint y) %% W16.modulus.
proof.
rewrite /to_sint /smod.
case: (2 ^ (16 - 1) <= to_uint x) => Cx.
 case: (2 ^ (16 - 1) <= to_uint y) => Cy.
  rewrite -modzMm -modzDm -modzNm modzz /= modz_mod.
  rewrite -modzMm -modzDm -modzNm modzz /= !modz_mod.
  by rewrite modzMm.
 rewrite -modzMm -modzDm -modzNm modzz /= modz_mod.
 by rewrite modzMm.
case: (2 ^ (16 - 1) <= to_uint y) => Cy.
rewrite -modzMm -modzDm -modzNm modzz /= modz_mod.
by rewrite modzMm.
done.
qed.

lemma nosmt to_sintM (x y: W16.t):
 to_sint (x*y)
 = W16.smod ((to_sint x * to_sint y) %% W16.modulus).
proof.
by rewrite {1}/W16.to_sint to_uintM modzM_sint.
qed.

lemma nosmt modzD_sint (x y: W16.t):
 (to_sint x + to_sint y) %% W16.modulus
 = (to_uint x + to_uint y) %% W16.modulus.
proof.
rewrite /to_sint /smod.
case: (2 ^ (16 - 1) <= to_uint x);
 case: (2 ^ (16 - 1) <= to_uint y); smt().
qed.

lemma nosmt to_sintD (x y: W16.t):
 to_sint (x+y)
 = W16.smod ((to_sint x + to_sint y)%%W16.modulus). 
proof.
by rewrite {1}/W16.to_sint to_uintD modzD_sint.
qed.

lemma nosmt modzN_sint (x: W16.t):
 (- to_sint x) %% W16.modulus
 = (- to_uint x) %% W16.modulus.
proof.
rewrite /to_sint /smod.
case: (2 ^ (16 - 1) <= to_uint x); smt().
qed.

lemma nosmt to_sintN (x: W16.t):
 to_sint (-x)
 = W16.smod ((-to_sint x) %% W16.modulus).
proof.
by rewrite {1}/W16.to_sint to_uintN modzN_sint.
qed.

lemma nosmt modzB_sint (x y: W16.t):
 (to_sint x - to_sint y) %% W16.modulus
 = (to_uint x - to_uint y) %% W16.modulus.
proof.
rewrite /to_sint /smod.
case: (2 ^ (16 - 1) <= to_uint x);
 case: (2 ^ (16 - 1) <= to_uint y); smt().
qed.

lemma nosmt to_sintB (x y: W16.t):
 to_sint (x-y)
 = W16.smod ((to_sint x - to_sint y)%%W16.modulus). 
proof.
rewrite {1}/W16.to_sint to_uintD to_uintN modzB_sint /#.
qed.

lemma nosmt wmulsE (x y: W16.t):
 to_sint x * to_sint y
 = to_sint (wmulhs x y) * W16.modulus
   + to_uint (x * y).
proof.
rewrite (divz_eq (to_sint x * to_sint y) W16.modulus) to_uintM.
congr; last by rewrite modzM_sint.
rewrite /wmulhs of_sintK smod_small //.
have /=?:= to_sint_cmp x.
have /=?:= to_sint_cmp y.
smt().
qed.

lemma nosmt to_sint_wmulhs x y:
 to_sint (W16.wmulhs x y) = to_sint x * to_sint y %/ W16.modulus.
proof.
rewrite wmulsE divzDl 1:/# mulzK 1:/#; ring.
rewrite divz_small //.
move: (to_uint_cmp (x*y)); smt().
qed.

abbrev sint_bnd xL xH x =
 xL <= W16.to_sint x <= xH.

lemma to_sint_bnd (x: W16.t):
 sint_bnd W16.min_sint W16.max_sint x
by move: (to_sint_cmp x); smt().

lemma sint_bndW (x: W16.t) (xL1 xH1 xL2 xH2: int):
 xL2 <= xL1 => xH1 <= xH2 =>
 sint_bnd xL1 xH1 x =>
 sint_bnd xL2 xH2 x
by smt().

lemma nosmt to_sintD_small (x y: W16.t):
 W16.min_sint <= to_sint x + to_sint y <= W16.max_sint =>
 to_sint (x+y) = to_sint x + to_sint y.
proof.
move=> /=?; rewrite to_sintD smod_small /= /#.
qed.

(* a version of [to_sintD_small] with bounds *)
lemma nosmt to_sintD_small' (xL xH yL yH: int) (x y: W16.t):
 sint_bnd xL xH x =>
 sint_bnd yL yH y =>
 W16.min_sint <= xL+yL =>
 xH+yH <= W16.max_sint =>
 to_sint (x+y) = to_sint x + to_sint y.
proof.
by move=> /= *; rewrite to_sintD_small /#.
qed.

lemma nosmt to_sintN_small (x: W16.t):
 W16.min_sint < to_sint x =>
 to_sint (-x) = - to_sint x.
proof.
move=> H; rewrite to_sintN modzN_sint /to_sint.
have [/=??]:= to_uint_cmp x.
case: (to_uint x=0) => [->//=|C1].
have ->: (- to_uint x) %% W16.modulus 
         = W16.modulus - to_uint x.
 rewrite -{1}(add0z (-W16.to_uint _)).
 by rewrite -(modzz W16.modulus) modzDml modz_small /#.
move: H; rewrite /to_sint /smod /=.
case: (32768 <= to_uint x) => C2 H.
 have ->/=: !32768 <= 65536 - to_uint x; smt().
by have ->/=: 32768 <= 65536 - to_uint x; smt().
qed.

lemma to_sintB_small (x y: W16.t):
 W16.min_sint <= to_sint x - to_sint y <= W16.max_sint =>
 to_sint (x-y) = to_sint x - to_sint y.
proof.
by move=> /= ?; rewrite to_sintB smod_small /= /#.
qed.

lemma to_sintM_small (x y: W16.t):
 W16.min_sint <= to_sint x * to_sint y <= W16.max_sint =>
 to_sint (x*y) = to_sint x * to_sint y.
proof.
by move=> /= ?; rewrite to_sintM smod_small /= /#.
qed.

lemma to_sintD_bnd (x y: W16.t) (xL xH yL yH: int):
 sint_bnd xL xH x =>
 sint_bnd yL yH y =>
 W16.min_sint <= xL+yL =>
 xH+yH <= W16.max_sint =>
 sint_bnd (xL+yL) (xH+yH) (x+y).
proof.
by move=> /> *; rewrite to_sintD_small /#. 
qed.

lemma to_sintN_bnd (x: W16.t) (xL xH: int):
 sint_bnd xL xH x =>
 W16.min_sint < xL =>
 sint_bnd (-xH) (-xL) (-x).
proof.
by move=> /> *; rewrite to_sintN_small /#.
qed.

lemma to_sintB_bnd (x y: W16.t) (xL xH yL yH: int):
 sint_bnd xL xH x =>
 sint_bnd yL yH y =>
 W16.min_sint <= xL-yH =>
 xH-yL <= W16.max_sint =>
 sint_bnd (xL-yH) (xH-yL) (x-y).
proof.
by move=> /> *; rewrite to_sintB_small /#.
qed.

lemma to_sintM_bnd (x y: W16.t):
 sint_bnd W16.min_sint W16.max_sint (x*y) 
by apply to_sint_bnd.

lemma to_sintPos_bnd (i: int):
 0 <= i < W16.max_sint =>
 sint_bnd 0 i (W16.of_int i).
proof.
by move=> /> *; rewrite of_sintK smod_small /#.
qed.

abbrev MIN (a b: int) = if a < b then a else b.
abbrev MAX (a b: int) = if a < b then b else a.

lemma to_sintH_bnd (x y: W16.t) (xL xH yL yH: int):
 sint_bnd xL xH x =>
 sint_bnd yL yH y =>
 xL<=0 => 0<=xH => yL<=0 => 0<=yH =>
 sint_bnd (MIN (xL*yH) (xH*yL) %/ W16.modulus) (MAX (xL*yL) (xH*yH) %/ W16.modulus) (wmulhs x y).
proof.
move=> /> *.
have xyH_bnd:
 MIN (xL * yH) (xH * yL) <= to_sint x * to_sint y <= MAX (xL * yL) (xH * yH).
 case: (to_sint x < 0) => Cx.
  case: (to_sint y < 0) => Cy.
   have HC: 0 <= to_sint x * to_sint y <= (xL * yL).
    split => *; first smt().
    rewrite -IntID.mulrNN -(IntID.mulrNN xL).
    apply ler_pmul; smt().
   smt().
  have HC: xL*yH <= to_sint x * to_sint y <= 0.
   split; last by smt().
   rewrite -ler_opp2 -2!Domain.mulNr.
   apply ler_pmul; smt().
  smt().
 case: (to_sint y < 0) => Cy.
  have HC: xH*yL <= to_sint x * to_sint y <= 0.
   split; last smt().
   rewrite -ler_opp2 -2!Domain.mulrN.
   apply ler_pmul; smt().
  smt().
 have: 0 <= to_sint x * to_sint y <= xH*yH.
  split=> *; first smt().
  by apply ler_pmul; smt().
 smt().
by rewrite to_sint_wmulhs /#.
qed.


theory Montgomery16.
from Jasmin require import JWord.
import W16 ALU.

abbrev R = W16.modulus.
op q = 3329.
op qinv = 62209.

lemma q_qinv: (q*qinv) %% R = 1 by done.

op Rinv = 169.
lemma RRinv: (R * Rinv) %% q = 1 %% q by done.

(** Montgomery reduction (args are Low/Hi-words to be reduced) *)
op REDC16 (xyL xyH: W16.t): W16.t =
 let m = xyL * W16.of_int qinv
 in xyH - (wmulhs m (W16.of_int q)).

(* general bounds... *)
lemma nosmt REDC16_correct bL bR (xyL xyH: W16.t):
 W16.min_sint + 1664 <= bL <= 0 =>
 0 <= bR <= W16.max_sint - 1665 =>
 sint_bnd bL bR xyH =>
 to_sint (REDC16 xyL xyH) %% q
 = (to_sint xyH * R + to_uint xyL) * Rinv %% q
 /\ sint_bnd (bL-1664) (bR+1665) (REDC16 xyL xyH).
proof.
(* BOUNDS *)
move=> /= [HbL1 HbL2] [HbR1 HbR2] xyH_bnd.
have := to_sint_bnd xyL.
rewrite /= => xyL_bnd.
pose m:= xyL * (W16.of_int qinv).
have := to_sint_bnd m.
rewrite /= => m_bnd.
have := to_sintPos_bnd q _ => //.
rewrite /q /= => q_bnd.
have := to_sintH_bnd _ _ _ _ _ _ m_bnd q_bnd _ _ _ _ => //. 
rewrite /q /= => mqH_bnd.
have := to_sintB_bnd _ _ _ _ _ _ xyH_bnd mqH_bnd _ _; first 2 smt().
move => t_bnd; split; last done.
(* CORRECTNESS *)
rewrite -(mulz1 (to_sint (REDC16 _ _)))
 -modzMmr -RRinv modzMmr -mulzA.
have ->:
  to_sint (REDC16 xyL xyH) * R
  = (to_sint xyH * R + to_uint xyL
     - to_sint (xyL * (W16.of_int qinv)) * q).
 rewrite /REDC16 /= to_sintB_small 1:/#.
 rewrite mulrDl -addzA eq_sym; congr.
 rewrite {1}(_:q=to_sint (W16.of_int q)).
  by rewrite of_sintK /q /smod.
 rewrite wmulsE -WRingA.mulrA !to_uintM. 
 rewrite !of_uintK /qinv /q /= to_uint_mod.
 by ring.
rewrite -modzMml eq_sym -modzMml /q /=.
congr; congr; congr.
by rewrite eq_sym -modzDmr -Domain.mulNr -modzMm modzz mod0z.
qed.

(* useful specific case *)
lemma nosmt REDC16_correct_q (xyL xyH: W16.t):
 sint_bnd (-q%/2) (q%/2 - 1) xyH =>
 to_sint (REDC16 xyL xyH) %% q
 = (to_sint xyH * R + to_uint xyL) * Rinv %% q
 /\ sint_bnd (-(q-1)) (q-1) (REDC16 xyL xyH).
proof.
move => Hbnd.
have [H1 H2]:= REDC16_correct _ _ xyL xyH _ _ Hbnd; first 2 smt().
split; first done.
by apply (sint_bndW _ _ _ _ _ _ _ H2); smt().
qed.

(** Montgomery multiplication *)
abbrev REDCmul16 (x y: W16.t): W16.t = REDC16 (x*y) (wmulhs x y).

(* correctness result for multiplication, for
 the specific case of a reduced argument *)
lemma nosmt REDCmul16_correct (x y: W16.t):
 sint_bnd 0 (q-1) y =>
 to_sint (REDCmul16 x y) %% q
 = to_sint x * to_sint y * Rinv %% q
 /\ sint_bnd (-(q-1)) (q-1) (REDCmul16 x y).
proof.
rewrite /q /= => y_bnd.
have := to_sint_bnd x.
rewrite /= => x_bnd.
have := to_sintH_bnd x y _ _ _ _ x_bnd y_bnd _ _ _ _ => //.
rewrite /q /= => xyH_bnd.
rewrite wmulsE.
by apply (REDC16_correct_q (x*y) (wmulhs x y)). 
qed.

end Montgomery16.


