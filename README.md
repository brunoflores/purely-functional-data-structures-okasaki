# purely-functional-data-structures-okasaki

Purely Functional Data Structures, by Chris Okasaki [^1].

> However, there is one aspect of functional programming
> that no amount of cleverness on the part of the compiler
> writer is likely to mitigate - the use of inferior or inappropriate
> data structures.

Why a language with _strict_ evaluation?

> Strict languages can describe worst-case data structures,
> but not amortized ones, and lazy languages can describe
> amortized data structures, but not worst-case ones.

> To be able to describe both kinds of data structures,
> we need a programming language that supports both evaluation
> orders.

Robert Harper [^2],

> [..] content ourselves with the observation that
> _laziness is a special case of eagerness_.

## Terminology

- _Abstract data type_: A type and a collection of functions on that type.
Also, simply an _abstraction_.
- _Concrete realization_: Also _implementation_. Implementation need not be
actualized as code - a concrete design is sufficient.
- _Instance of data type_: Such as a particular list or tree.
Refer to such an instance in general as _object_ or a _version_.
- _Unique identity, invariant under updates_: Refer to this identity as a
_persistent identity_. When we speak of different versions of the same
data structure, we mean that the different versions share a common
persistent identity.

| Concept          | SML                       |
|:-----------------|:--------------------------|
| Abstractions     | Signatures in Standard ML |
| Implementations  | Structures or functors    |
| Objects/versions | Values                    |

## Chapters

- Chapter 1: Introduction (you are here)
- [Chapter 2: Persistence](ch2)
- [Chapter 3: Some Familiar Data Structures in a Functional Setting](ch3)
- [Chapter 4: Lazy Evaluation](ch4)

Files in [lib/](lib/) define shared definitions.

## Test

Files in [driver/](driver/) are type-checked, compiled, linked and executed 
by [Github actions](.github/workflows/).

[^1]: Okasaki, C. (1999). Purely functional data structures.
[^2]: Robert Harper. Programming in Standard ML. Draft, 2013.
