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
