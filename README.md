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


[^1]: Okasaki, C. (1999). Purely functional data structures.
[^2]: Robert Harper. Programming in Standard ML. Draft, 2013.
