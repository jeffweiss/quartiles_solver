defmodule QuartilesSolver.Trie do
  @doc """
  Modified version of Okasaki's Trie, Purely Functional Data Structures, page 165
  """

  @type search_path() :: charlist()
  @type payload() :: any()
  @type value() :: :none | {:some, payload()}
  @type trie() :: {value(), Map.t()}

  @empty {:none, %{}}

  @spec lookup(trie(), String.t() | search_path()) :: :not_found | payload()
  def lookup(trie, word) when is_binary(word), do: lookup(trie, String.to_charlist(word))
  def lookup({:none, _}, []), do: :not_found
  def lookup({{:some, payload}, _}, []), do: payload
  def lookup({_trie, children}, [key | rest]), do: lookup(Map.get(children, key, @empty), rest)

  @spec bind(trie(), String.t() | search_path(), payload()) :: trie()
  def bind(trie, path, payload) when is_binary(path) do
    bind(trie, String.to_charlist(path), payload)
  end

  def bind({_, children}, [], payload), do: {{:some, payload}, children}

  def bind({value, children}, [key | rest], payload) do
    t = Map.get(children, key, @empty)

    t_prime = bind(t, rest, payload)
    {value, Map.put(children, key, t_prime)}
  end

  def new, do: @empty
end
