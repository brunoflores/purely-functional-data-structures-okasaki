(* Practicing with suspensions in SML/NJ.
*  The expensive computation is done just once.
*)

open SMLofNJ.Susp

fun plus (x, y) = force x + y

fun expensive_int x =
  let val c = ref 0
  in
    print ("count: " ^ (Int.toString (!c)));
    print "\n";
    c := !c + 1;
    x
  end

fun delayed_int x = delay (fn unit => expensive_int x)
val expensive_result = delayed_int 2

val lazy_comp = plus (expensive_result, 2)
val lazy_comp' = plus (expensive_result, 2)
