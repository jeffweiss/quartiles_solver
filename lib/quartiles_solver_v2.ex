defmodule QuartilesSolver.V2 do
  alias QuartilesSolver.Trie

  def dictionary do
    "/usr/share/dict/words"
    |> File.stream!(:line)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(String.length(&1) > 13))
    |> Enum.reduce(Trie.new(), &Trie.bind(&2, &1, &1))
  end

  def possibilities(max, _) when max <= 0, do: [[]]

  def possibilities(max, tiles) do
    # IO.inspect(%{max: max, tiles: tiles}, label: "recursive possibilities")
    for elem <- tiles, rest <- possibilities(max - 1, tiles -- [elem]) do
      [elem | rest]
    end
  end

  def solutions(tiles, dictionary) do
    for max <- 1..4,
        permutation <- possibilities(max, tiles),
        candidate_word = Enum.join(permutation),
        Trie.lookup(dictionary, candidate_word) == candidate_word do
      candidate_word
    end
  end
end
