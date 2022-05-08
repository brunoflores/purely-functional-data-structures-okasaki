functor PairingHeap (Element : Ordered) : Heap = struct
  structure Elem = Element

  datatype Heap = E | T of Elem.t * Heap list

  val empty = E

  fun isEmpty E = true
    | isEmpty _ = false

  fun merge (h, E) = h
    | merge (E, h) = h
    | merge (h1 as T (x, hs1), h2 as T (y, hs2)) =
        if Elem.leq (x, y) then T (x, h2 :: hs1) else T (y, h1 :: hs2)

  fun insert (x, h) = merge (T (x, []), h)

  fun mergePairs [] = E
    | mergePairs [h] = h
    | mergePairs (h1 :: h2 :: hs) = merge (merge (h1, h2), mergePairs hs)

  fun findMin E = raise Empty
    | findMin (T (x, _)) = x

  fun deleteMin E = raise Empty
    | deleteMin (T (_, hs)) = mergePairs hs

end
