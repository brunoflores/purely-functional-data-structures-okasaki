signature Set = sig
  type Elem
  type Set

  val empty : Set

  val insert : Elem * Set -> Set
  val insert' : Elem * Set -> Set

  val member : Elem * Set -> bool
  val member' : Elem * Set -> bool
end

(* A totally ordered type and its comparison functions. *)
signature Ordered = sig
  type t

  val eq : t * t -> bool
  val lt : t * t -> bool
  val leq : t * t -> bool
end

(* Implementation of binary search trees as a SML functor. *)
functor UnbalancedSet (Element : Ordered) : Set = struct
  type Elem = Element.t

  datatype Tree = E | T of Tree * Elem * Tree

  type Set = Tree

  val empty = E

  fun member (x, E) = false
    | member (x, T (a, y ,b)) =
        if Element.lt (x, y) then member (x, a)
        else if Element.lt (y, x) then member (x, b)
        else true

  fun insert (x, E) = T (E, x, E)
    | insert (x, s as T (a, y, b)) =
        if Element.lt (x, y) then T (insert (x, a), y, b)
        else if Element.lt (y, x) then T (a, y, insert (x, b))
        else s

  (* Exercise 2.2
  *  The idea here is to remedy the situation with [member] above,
  *  where, in the worst case, it performs 2d comparisons, where
  *  d is the depth of the tree.
  *  In this solution I keep track of csndidate elements that
  *  might be equal to the query element, and check for equality
  *  only when hitting the bottom of the tree (the base case).
  *)
  fun member' (x, E) = false
    | member' (x, s as T (_, y, _)) =
        let fun loop (c, E) = Element.eq (x, c)
              | loop (c, T (a, y, b)) = if Element.lt (x, y)
                                        then loop (c, a)
                                        else loop (c, b)
        in
          loop (x, s)
        end

  (* Exercise 2.3
  *  Avoid unnecessary copying when inserting an existing element
  *)
  fun insert' (x, s) =
    let exception SameValue
        fun loop E             = T (E, x, E)
          | loop (T (a, y, b)) = if Element.lt (x, y) then T (loop a, y, b)
                                 else if Element.lt (y, x) then T (a, y, loop b)
                                 else raise SameValue
    in
      loop s
    end
    handle SameValue => s
end
