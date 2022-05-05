signature Queue = sig
  type 'a Queue

  val empty   : 'a Queue
  val isEmpty : 'a Queue -> bool

  val snoc : 'a Queue * 'a -> 'a Queue
  val head : 'a Queue -> 'a            (* raises Empty if queue is empty *)
  val tail : 'a Queue -> 'a Queue      (* raises Empty if queue is empty *)
end

(* Illustrate the banker's and psysicist's methods by analyzing a simple
   functional implementation of the FIFO queue abstraction. *)

structure BatchedQueue : Queue = struct
  type 'a Queue = 'a list * 'a list

  val empty = ([], [])
  fun isEmpty (f, _) = null f

  (* Maintain invariant that f is empty only if r is also empty (the entire
     queue is empty. *)
  fun checkf ([], r) = (rev r, [])
    | checkf q = q

  fun snoc ((f, r), x) = checkf (f, x :: r)

  fun head ([], _) = raise Empty
    | head (x :: _, _) = x

  fun tail ([], _) = raise Empty
    | tail (_ :: f, r) = checkf (f, r)
end

(* The analysis goes like this:
*
*  Banker's Method:
*
*  1. Maintain a credit invariant that every element in rear list is
*  associated with a single credit.
*
*  2. Every snoc into a non-empty queue takes one actual step and allocates
*  a credit to the new element of the rear list, for an amortized cost of two.
*
*  3. Every tail that does not reverse the rear list takes one actual step
*  and neither allocates nor spends any credits, for an amortized cost of one.
*
*  4. Finally, every tail that does reverse the rear list takes m+1 actual
*  steps, where m is the length of the rear list, and spends the m credits
*  contained by that list, for an amortized cost of m+1-m=1.
*
*  Physicist's Method:
*
*  1. Define the potential function to be the length of the rear list.
*
*  2. Every snoc into a non-empty queue takes one actual step and increases
*  the potential by one, for an amortized cost of two.
*
*  3. Every tail that does not reverse the rear list takes one actual step
*  and leaves the potential unchanged, for an amortized cost of one.
*
*  4. Finally, every tail that does reverse the rear list takes m+1 actual
*  steps and sets the new rear list to [], decreasing the potential by m,
*  for an amortized cost of m+1-m=1.
*
*  snoc and head run in O(1) worst-case time, but tail takes O(n) time in the
*  worst-case. However, snoc and tail both take O(1) amortized time.
*
*)
