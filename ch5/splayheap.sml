functor SplayHeap (Element : Ordered) : Heap = struct
  structure Elem = Element

  datatype Heap = E | T of Heap * Elem.t * Heap

  val empty = E

  fun isEmpty E = true
    | isEmpty _ = false

  fun partition (pivot, E) = (E, E)
    | partition (pivot, t as T (a, x, b)) = (
        if Elem.leq (x, pivot) then (
          case b of E => (t, E)
             | T (b1, y, b2) =>
                 if Elem.leq (y, pivot) then
                   let val (small, big) = partition (pivot, b2)
                   in (T (T (a, x, b1), y, small), big) end
                 else
                   let val (small, big) = partition (pivot, b1)
                   in (T (a, x, small), T (big, y, b2)) end
        ) else (
          case a of E => (E, t)
             | T (a1, y, a2) =>
                 if Elem.leq (y, pivot) then (
                   let val (small, big) = partition (pivot, a2)
                   in (T (a1, y, small), T (big, x, b)) end
                 ) else (
                   let val (small, big) = partition (pivot, a1)
                   in (small, T (big, y, T (a2, x, b))) end)))

  fun insert (x, t) = let val (a, b) = partition (x, t) in T (a, x, b) end

  fun merge (E, t) = t
    | merge (T (a, x, b), t) =
        let val (ta, tb) = partition (x, t)
        in T (merge (ta, a), x, merge (tb, b)) end

  fun findMin E = raise Empty
    | findMin (T (E, x, _)) = x
    | findMin (T (a, _, _)) = findMin a

  fun deleteMin E = raise Empty
    | deleteMin (T (E, _, b)) = b
    | deleteMin (T (T (E, _, b), y, c)) = T (b, y, b)
    | deleteMin (T (T (a, x, b), y, c)) = T (deleteMin a, x, T (b, y, c))

end
