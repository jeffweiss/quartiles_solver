# QuartilesSolver

Quartiles is a game on Apple News+.

You are given a set of 20 tiles, each word substrings from 2-4 characters long.
The goal is to combine them to find as many words as possible, including each of
the 5 words that use a unique combination of 4 tiles each.

Because I enjoyed the daily challenge of the game, I thought I would suck all
the frustration (and thus enjoyment) out of it by automating its solution.

## Initial Implementation

The initial naive implementation uses the `Enum.member?/2` function to check if a
potential tile permutation is a word. This is slow as the dictionary of words is
fairly sizable.

```elixir
iex(1)> tiles = ~w(nsi li ito ment cal ick ri bro ols apo hom om ti gn ous co st
mer cho es)
["nsi", "li", "ito", "ment", "cal", "ick", "ri", "bro", "ols", "apo", "hom",
 "om", "ti", "gn", "ous", "co", "st", "mer", "cho", "es"]
iex(2)> dictionary = QuartilesSolver.dictionary
iex(3)> :timer.tc(QuartilesSolver, :solutions, [tiles, dictionary])
{131860373,
 ["li", "cal", "om", "ti", "st", "cho", "es", "list", "limer", "calli",
  "calmer", "rist", "rimer", "broom", "brocho", "tical", "timer", "coli",
  "coom", "cost", "comer", "stick", "mercal", "choli", "homesick", "consign",
  "consist", "colical", "merriment", "chorist", "broomstick", "consignment",
  "meritorious"]}


```

## Trie Implementation

The significantly faster Trie implementation uses the
[Trie data structure](https://en.wikipedia.org/wiki/Trie) as outlined by
[Okasaki](https://en.wikipedia.org/wiki/Chris_Okasaki) in Purely Functional Data
Structures. This project's trie implementation is slightly more ergonomic for Elixir
idioms.

```elixir
iex(1)> tiles = ~w(nsi li ito ment cal ick ri bro ols apo hom om ti gn ous co st
mer cho es)
["nsi", "li", "ito", "ment", "cal", "ick", "ri", "bro", "ols", "apo", "hom",
 "om", "ti", "gn", "ous", "co", "st", "mer", "cho", "es"]
iex(2)> dictionary = QuartilesSolver.V2.dictionary
iex(3)> :timer.tc(QuartilesSolver.V2, :solutions, [tiles, dictionary])
{75462,
 ["li", "cal", "om", "ti", "st", "cho", "es", "list", "limer", "calli",
  "calmer", "rist", "rimer", "broom", "brocho", "tical", "timer", "coli",
  "coom", "cost", "comer", "stick", "mercal", "choli", "homesick", "consign",
  "consist", "colical", "merriment", "chorist", "broomstick", "consignment",
  "meritorious"]}

```

In this case, the trie implementation ran in 75ms, while the naive
implementation took 131s. The improvement runs in less than 0.06% of the time of
the original.
