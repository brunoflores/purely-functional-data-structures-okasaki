# Chapter 5: Fundamentals of Amortization

Given a sequence of operations, we may wish to know the running time of the
entire sequence, but not care about the running time of any individual
operation.

For instance, given a sequence of _n_ operations, we may wish to bound the
total running time of the sequence to _O(n)_ without insisting that every
individual operation run in _O(1)_.

**This freedom opens up a wide design space.**

## Some terminology

Define the amortized cost of each operation and then prove that,
for any sequence of operations, the total amortized cost of the operations
is an upper bound on the total actual cost,

<img src="https://latex.codecogs.com/png.image?\large&space;\dpi{150}\bg{white}\sum_{m}^{i=1}{a_i}\geqslant\sum_{m}^{i=1}{t_i}" title="https://latex.codecogs.com/png.image?\large \dpi{150}\bg{white}\sum_{m}^{i=1}{a_i}\geqslant\sum_{m}^{i=1}{t_i}" />

where _ai_ is the amortized cost of operation _i_, _ti_ is the actual
cost of operation _i_, and _m_ is the total number of operations.

The difference between the accumulated amortized costs and the accumulated
actual costs is called the _accumulated savings_. The accumulated amortized
costs are an upper bound on the accumulated actual costs whenever the
accumulated savings is non-negative.

Operations called _expensive_ are the ones that exceed their amortized costs.
Others are called _cheap_.

**The key to proving amortized** bounds is to show that expensive operations
occur only when the accumulated savings are sufficient to cover the remaining
cost.

## The Banker's Method

Accumulated savings are represented as _credits_ that are associated with
individual locations in the data structure.

The amortized cost of any operation is defined to be the actual cost of
the operation plus the credits allocated by the operation minus
the credits spent by the operation,

<img src="https://latex.codecogs.com/png.image?\large&space;\dpi{150}\bg{white}a_i=t_i&plus;c_i-\overline{c_i}" title="https://latex.codecogs.com/png.image?\large \dpi{150}\bg{white}a_i=t_i+c_i-\overline{c_i}" />
