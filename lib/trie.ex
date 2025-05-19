defmodule QuartilesSolver.Trie do
  @doc """
  Modified version of Okasaki's Trie, Purely Functional Data Structures, page 165
  """

  @type trie() :: {:none, Map.t()} | {{:some, String.t()}, Map.t()}
  @type search_path() :: charlist()
  @type payload() :: String.t()

  @empty {:none, %{}}

  @spec lookup(trie(), String.t() | search_path()) :: :not_found | payload()
  def lookup(trie, word) when is_binary(word), do: lookup(trie, String.to_charlist(word))
  def lookup({:none, _}, []), do: :not_found
  def lookup({{:some, x}, _}, []), do: x
  def lookup({_trie, m}, [k | ks]), do: lookup(Map.get(m, k, @empty), ks)

  @spec bind(trie(), String.t() | search_path(), payload()) :: trie()
  def bind(trie, path, payload) when is_binary(path) do
    bind(trie, String.to_charlist(path), payload)
  end

  def bind({_, m}, [], x), do: {{:some, x}, m}

  def bind({v, m}, [k | ks], x) do
    t =
      case Map.get(m, k) do
        nil -> @empty
        other -> other
      end

    t_prime = bind(t, ks, x)
    {v, Map.put(m, k, t_prime)}
  end

  def new, do: @empty
end
