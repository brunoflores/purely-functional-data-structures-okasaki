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

- <lists.sml>

## Binary search trees

`TODO`
