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
  *
  *  In this solution I keep track of a candidate element [c] that
  *  might be equal to the query element [x], and check for equality
  *  only when hitting the bottom of the tree (the base case).
  *
  *  This solution takes no more than d+1 comparisons.
  *)
  fun member' (x, E) = false
    | member' (x, s as T (_, y, _)) =
        let fun loop (c, E) = Element.eq (x, c) (* this is always the bottom a non-empty tree;
                                                   compares query with final candidate;
                                                   never reaches here on first iteration *)
              | loop (c, T (a, y, b)) = if Element.lt (x, y)
                                        then loop (c, a) (* keep same candidate and look left *)
                                        else loop (y, b) (* replace candidate and look right *)
        in
          loop (y, s) (* begin with the obvious first candidate *)
        end

  (* Exercise 2.3
  *  Avoid unnecessary copying when inserting an existing element.
  *)
  fun insert' (x, s) =
    let exception SameValue
        fun loop E             = T (E, x, E)
          | loop (T (a, y, b)) = if Element.lt (x, y) then T (loop a, y, b)
                                 else if Element.lt (y, x) then T (a, y, loop b)
                                 else raise SameValue (* avoid copy *)
    in
      loop s
    end
    handle SameValue => s

  (* Exercise 2.4
  *  Combine ideas above for the insert case.
  *  No unnecessary copying and uses no more than d+1 comparisons.
  *
  *  Use an exception as a form of back-tracking to avoid copying
  *  when reaching the bottom of the tree and realising the element
  *  is already there.
  *)
  fun insert'' (x, E) = T (E, x, E)
    | insert'' (x, s as T (_, y, _)) =
        let exception SameValue
            fun loop (c, E) = if Element.eq (x, c)
                              then raise SameValue (* avoid copy *)
                              else T (E, x, E) (* insert at the bottom of tree *)
              | loop (c, T (a, y, b)) = if Element.lt (x, y)
                                        then T (loop (c, a), y, b) (* keep same candidate and look left *)
                                        else T (a, y, loop (y, b)) (* replace candidate and look right *)
        in
          loop (y, s)
        end
        handle SameValue => s

  (* Exercise 2.5 *)
  fun complete (x, 0) = E
    | complete (x, d) =
        let val t = complete (x, d-1) in
          T (t, x, t)
        end

  fun create (x, 0) = E
    | create (x, n) =
        let fun create2 (x, m) = (create (x, m), create (x, m+1)) in
          if (n-1) mod 2 = 0 then
            let val t = create (x, (n-1) div 2) in
              T (t, x, t)
            end
          else
            let val (l, r) = create2 (x, (n-1) div 2) in
              T (l, x, r)
            end
        end
end

(* Exercise 2.6 *)
exception NotFound

signature FiniteMap = sig
  type Key
  type 'a Map

  val empty : 'a Map
  val bind : Key * 'a * 'a Map -> 'a Map
  val lookup : Key * 'a Map -> 'a
end

functor UnbalancedFiniteMap (Element : Ordered) : FiniteMap = struct
  type Key = Element.t

  datatype 'a Tree = E | T of 'a Tree * Key * 'a * 'a Tree

  type 'a Map = 'a Tree

  val empty = E

  fun bind (k, v, E) = T (E, k, v, E)
    | bind (k, v, t as T (a, k', v', b)) =
        if Element.lt (k, k') then T (bind (k, v, a), k', v', b)
        else if Element.lt (k', k) then T (a, k', v', bind (k, v, b))
        else t

  fun lookup (k, E) = raise NotFound
    | lookup (k, T (a, k', v', b)) =
        if Element.lt (k, k') then lookup (k, a)
        else if Element.lt (k', k) then lookup (k, b)
        else v'
end
