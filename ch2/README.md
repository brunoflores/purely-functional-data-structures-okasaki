# Chapter 2: Persistence

_Versions:_ Functional data structures are always _persistent_.

Updating a functional data structure does not destroy the existing
version, but rather creates a new version that coexists with the
old one.

**Copying and sharing**

Persistence by _copying_ affected nodes and making all changes in the copy.
Nodes unaffected by an update can be _shared_ between versions.

## Lists

Files:

- [lists.sml](lists.sml)

## Binary search trees

Recap: Binary trees with elements stored at the interior nodes in
_symmetric order_. In SML:

```sml
datatype Tree = E | T of Tree * Elem * Tree
```

where `Elem` is some fixed type of _totally-ordered elements_.

Not polymorphic in the type of elements because they cannot accept
arbitrary types as elements. We make the type of elements and its
attendant comparison functions parameter of the _functor_ that
implements binary search trees.
