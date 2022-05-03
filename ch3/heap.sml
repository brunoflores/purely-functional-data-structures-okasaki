use "../std-lib.sml";

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

functor LeftistHeap (Element : Ordered) : Heap = struct
  structure Elem = Element

  datatype Heap = E | T of int * Elem.t * Heap * Heap

  fun rank E = 0
    | rank (T (r, _, _, _)) = r

  (* Calculate the rank of a T node and swaps its children if necessary. *)
  fun makeT (x, a, b) = if rank a >= rank b
                        then T (rank b + 1, x, a, b)
                        else T (rank a + 1, x, b, a)

  val empty = E

  fun isEmpty E = true
    | isEmpty _ = false

  (* Key insight behind leftist heaps:
  *  two heaps can be merged by merging their right spines as you would merge
  *  two sorted lists, and the swapping the children of nodes along this path
  *  as necessary to restore the leftist property.
  *)
  fun merge (h, E) = h
    | merge (E, h) = h
    | merge (h1 as T (_, x, a1, b1), h2 as T (_, y, a2, b2)) =
        (* The behaviour is two passes:
        *  a top-down pass of calls to merge, and
        *  a bottom-up pass of calls to makeT.
        *)
        if Elem.leq (x, y)
        then makeT (x, a1, merge (b1, h2))
        else makeT (y, a2, merge (h1, b2))

  fun insert (x, h) = merge (T (1, x, E, E), h)

  (* Excercise 3.2 *)
  fun insert' (x, E) = T (1, x, E, E)
    | insert' (x, h as T (r, y, a, b)) =
        if Elem.leq (x, y)
        then T (1, x, h, E)
        else makeT (y, a, insert' (x, b))

  fun findMin E = raise Empty
    | findMin (T (_, x, _, _)) = x

  fun deleteMin E = raise Empty
    | deleteMin (T (_, _, a, b)) = merge (a, b)

  (* Exercise 3.3 *)
  fun fomList xs =
    let fun mergeList ([]) = E
          | mergeList ([x]) = x
          | mergeList (x1 :: x2 :: xs) = mergeList (merge (x1, x2) :: xs)
        fun toTreeList [] = E :: []
          | toTreeList (x :: xs) = T (1, x, E, E) :: toTreeList xs
    in
      mergeList (toTreeList xs)
    end

end

functor BinomialHeap (Element : Ordered) : Heap = struct
  structure Elem = Element

  datatype Tree = Node of int * Elem.t * Tree list
  type Heap = Tree list

  val empty = []
  fun isEmpty ts = null ts

  fun rank (Node (r, _, _)) = r
  fun root (Node (_, x, _)) = x

  fun link (t1 as Node (r, x1, c1), t2 as Node (_, x2, c2)) =
    if Elem.leq (x1, x2) then Node (r+1, x1, t2 :: c1)
    else Node (r+1, x2, t1 :: c2)

  fun insTree (t, []) = [t]
    | insTree (t, ts as t' :: ts') =
        if rank t < rank t' then t :: ts else insTree (link (t, t'), ts')

  fun insert (x, ts) = insTree (Node (0, x, []), ts)

  fun merge (ts1, []) = ts1
    | merge ([], ts2) = ts2
    | merge (ts1 as t1 :: ts1', ts2 as t2 :: ts2') =
        if rank t1 < rank t2 then t1 :: merge (ts1', ts2)
        else if rank t2 < rank t1 then t2 :: merge (ts1, ts2')
        else insTree (link (t1, t2), merge (ts1', ts2'))

  fun removeMinTree [] = raise Empty
    | removeMinTree [t] = (t, [])
    | removeMinTree (t :: ts) =
        let val (t', ts') = removeMinTree ts
        in if Elem.leq (root t, root t') then (t, ts) else (t', t :: ts') end

  fun findMin ts = let val (t, _) = removeMinTree ts in root t end

  fun deleteMin ts =
    let val (Node (_, _, ts1), ts2) = removeMinTree ts
    in merge (rev ts1, ts) end

end

functor RedBlackSet (Element : Ordered) : Set = struct
  type Elem = Element.t

  datatype Color = R | B
  datatype Tree = E | T of Color * Tree * Elem * Tree
  type Set = Tree

  val empty = E

  fun member (x, E) = false
    | member (x, T (_, a, y, b)) =
      if Element.lt (x, y) then member (x, a)
      else if Element.lt (y, x) then member (x, b)
      else true

  (* Balance function detects and repairs each red-red violation when it
  *  processes the black parent of the red node with a red child.
  *
  *  This black-red-red path can occur in any of four configurations, depending
  *  on whether each red node is a left or right child. However, the solution
  *  is the same in every case: rewrite the black-red-red path as a red node
  *  with two black children.
  *)
  fun balance ( (B,T (R,T (R,a,x,b),y,c),z,d)
              | (B,T (R,a,x,T (R,b,y,c)),z,d)
              | (B,a,x,T (R,T (R,b,y,c),z,d))
              | (B,a,x,T (R,b,y,T (R,c,z,d))) ) =
                  T (R,T (B,a,x,b),y,T (B,c,z,d))
              | balance body = T body

  fun insert (x, s) =
    let fun ins E = T (R, E, x, E) (* initially color it red *)
          | ins (s as T (color, a, y, b)) =
              if Element.lt (x, y) then balance (color, ins a, y, b)
              else if Element.lt (y, x) then balance (color, a, y, ins b)
              else s
        val T (_, a, y, b) = ins s (* guaranteed non-empty *)
    in
      T (B, a, y, b) (* force the final root to be black *)
    end

end
