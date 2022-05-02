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
