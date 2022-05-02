signature Set = sig
  type Elem
  type Set

  val empty : Set
  val insert : Elem * Set -> Set
  val member : Elem * Set -> bool
end
