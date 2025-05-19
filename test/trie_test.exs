defmodule QuartilesSolver.TrieTest do
  use ExUnit.Case
  doctest QuartilesSolver.Trie

  alias QuartilesSolver.Trie

  test "can lookup a bound value" do
    sample_words = ~w(car card carton cat dog)

    populated_trie =
      Enum.reduce(
        sample_words,
        Trie.new(),
        fn word, trie ->
          Trie.bind(trie, word, word)
        end
      )

    for word <- sample_words do
      assert Trie.lookup(populated_trie, word) == word
    end

    assert Trie.lookup(populated_trie, "cart") == :not_found
  end

  test "can use complex type for payload" do
    sample_words = ~w(car card carton cat dog)

    populated_trie =
      sample_words
      |> Enum.with_index()
      |> Enum.reduce(
        Trie.new(),
        fn {word, index}, trie ->
          Trie.bind(trie, word, {index, word})
        end
      )

    for {word, index} <- Enum.with_index(sample_words) do
      assert Trie.lookup(populated_trie, word) == {index, word}
    end
  end
end
