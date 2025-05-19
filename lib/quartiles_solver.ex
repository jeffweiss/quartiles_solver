defmodule QuartilesSolver do
  @moduledoc """
  Documentation for `QuartilesSolver`.
  """

  def dictionary do
    "/usr/share/dict/words"
    |> File.stream!(:line)
    |> Stream.map(&String.trim/1)
    |> Stream.reject(&(String.length(&1) > 13))
    |> Enum.to_list()
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
        Enum.member?(dictionary, candidate_word) do
      candidate_word
    end
  end
end
