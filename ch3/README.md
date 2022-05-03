# Chapter 3: Some Familiar Data Structures in a Functional Setting

Data structures that get persistence for free when implemented 
functionally.

## Leftist Heaps

Efficient access to the _minimum_ element.

Often implemented as _heap-ordered trees_:
The element at each node is no larger than
the elements at its children.

Leftist heaps:
- Heap-ordered binary trees
- Satisfy the _leftist property_: the rank of any left child is at least as
large as the rank of its right sibling

The _rank_ of a node: the length of its _right spine_
(the rightmost path from the node in question to an empty node).

Consequence of the leftist property: **the right spine of any node is always 
the shortest path to an empty node**.

Represent leftist heaps as binary trees decorated with rank information:

```sml
datatype Heap = E | T of int * Elem.t * Heap * Heap
```

Files:

- [heap.sml](heap.sml)

## Binomial Queues

`TODO`

## Red-Black Trees

One of the most popular families of balanced binary trees.

Binary search tree in which every node is colored either red or black. Two
balance invariants:

1. No red node has a red child
2. Every path from the root to an empty node contains the same number of
black nodes.

Taken together, these two invariants guarantee that the longest possible path
in a red-black tree, one with alternating black and red nodes, is no more
than twice as long as the shortest possible path, one with black nodes only.
