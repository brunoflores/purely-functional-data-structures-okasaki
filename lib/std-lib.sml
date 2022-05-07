(* A totally ordered type and its comparison functions. *)
signature Ordered = sig
  type t

  val eq : t * t -> bool
  val lt : t * t -> bool
  val leq : t * t -> bool
end

signature Set = sig
  type Elem
  type Set

  val empty : Set
  val insert : Elem * Set -> Set
  val member : Elem * Set -> bool
end

signature Heap = sig
  structure Elem : Ordered

  type Heap

  val empty   : Heap
  val isEmpty : Heap -> bool

  val insert : Elem.t * Heap -> Heap
  val merge  : Heap * Heap -> Heap

  val findMin   : Heap -> Elem.t (* raises Empty if heap is empty *)
  val deleteMin : Heap -> Heap   (* raises Empty if heap is empty *)
end

