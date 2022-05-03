use "../std-lib.sml";

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
      (* After balancing a given subtree, the red root of that subtree might
      *  now be the child of another red node. Thus, we continue balancing
      *  all the way to the top of the tree. At the very top of the tree, we
      *  might end up with a red node with a red child. We handle this case by
      *  always coloring the root to be black.
      *)
      T (B, a, y, b) (* force the final root to be black *)
    end

end
