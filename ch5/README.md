# Chapter 5: Fundamentals of Amortization

Given a sequence of operations, we may wish to know the running time of the
entire sequence, but not care about the running time of any individual
operation.

For instance, given a sequence of _n_ operations, we may wish to bound the
total running time of the sequence to _O(n)_ without insisting that every
individual operation run in _O(1)_.

**This freedom opens up a wide design space.**

## Some terminology

<img src="https://latex.codecogs.com/svg.image?\sum_{m}^{i=1}{a_i}\geqslant\sum_{m}^{i=1}{t_i}" title="https://latex.codecogs.com/svg.image?\sum_{m}^{i=1}{a_i}\geqslant\sum_{m}^{i=1}{t_i}" />
