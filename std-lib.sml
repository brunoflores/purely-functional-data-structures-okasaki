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
