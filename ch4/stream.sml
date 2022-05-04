open Lazy
(* open SMLofNJ.Susp *)

signature Stream = sig
  datatype 'a StreamCell = Nil | Cons of 'a * 'a Stream
  withtype 'a Stream = 'a StreamCell susp

  val append  : 'a Stream * 'a Stream -> 'a Stream
  val take    : int * 'a Stream -> 'a Stream
  val drop    : int * 'a Stream -> 'a Stream
  val reverse : 'a Stream -> 'a Stream
end

structure Stream : Stream = struct
  datatype 'a StreamCell = Nil | Cons of 'a * 'a Stream
  withtype 'a Stream = 'a StreamCell susp

  fun append ($ Nil, t) = t
    | append ($ (Cons (x, s)), t) = $ (Cons (x, append (s, t)))

  fun take (0, _) = $ Nil
    | take (_, $ Nil) = $ Nil
    | take (n, $ (Cons (x, s))) = $ (Cons (x, take (n-1, s)))

  fun drop (n ,s) =
    let fun drop' (0, s) = s
          | drop' (_, $ Nil) = $ Nil
          | drop' (n, $ (Cons (x, s))) = drop' (n-1, s)
    in drop' (n, s) end

  fun reverse s =
    let fun reverse' ($ Nil, r) = r
          | reverse' ($ (Cons (x, s)), r) = reverse' (s, $ (Cons (x, r)))
    in reverse' (s, $ Nil) end

end
