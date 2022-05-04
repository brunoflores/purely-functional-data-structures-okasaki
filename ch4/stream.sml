open Lazy
(* open SMLofNJ.Susp *)

signature Stream = sig
  datatype 'a StreamCell = NIL | CONS of 'a * 'a Stream
  withtype 'a Stream = 'a StreamCell susp

  val append  : 'a Stream * 'a Stream -> 'a Stream
  val take    : int * 'a Stream -> 'a Stream
  val drop    : int * 'a Stream -> 'a Stream
  val reverse : 'a Stream -> 'a Stream
end

structure Stream : Stream = struct
  datatype 'a StreamCell = NIL | CONS of 'a * 'a Stream
  withtype 'a Stream = 'a StreamCell susp

  fun append ($ NIL, t) = t
    | append ($ (CONS (x, s)), t) = $ (CONS (x, append (s, t)))

  fun take (0, _) = $ NIL
    | take (_, $ NIL) = $ NIL
    | take (n, $ (CONS (x, s))) = $ (CONS (x, take (n-1, s)))

  fun drop (n ,s) =
    let fun drop' (0, s) = s
          | drop' (_, $ NIL) = $ NIL
          | drop' (n, $ (CONS (x, s))) = drop' (n-1, s)
    in drop' (n, s) end

  fun reverse s =
    let fun reverse' ($ NIL, r) = r
          | reverse' ($ (CONS (x, s)), r) = reverse' (s, $ (CONS (x, r)))
    in reverse' (s, $ NIL) end

end
