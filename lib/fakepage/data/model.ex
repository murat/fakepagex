defmodule Fakepage.Data.Model do
  @moduledoc """
  This module starts an Agent that implements Markov Chain Model.

  Reference: https://neiro.io/2016-07-31-markov-chains-in-elixir.md.html
  """

  import Fakepage.Data.Tokenizer

  # create map for sharing through agent
  @spec start_link :: {:error, any} | {:ok, pid}
  def start_link, do: Agent.start_link(fn -> %{} end)

  @spec populate(pid, binary) :: pid
  def populate(pid, text) do
    # populate model with tokens
    for tokens <- tokenize(text), do: modelize(pid, tokens)
    pid
  end

  @spec fetch_token(any, pid) :: {any, float}
  def fetch_token(state, pid) do
    tokens = fetch_tokens(state, pid)

    if length(tokens) > 0 do
      # do not take random, user may want to choose start word
      token = Enum.random(tokens)

      count =
        tokens
        |> Enum.count(&(token == &1))

      # count probability of the token
      {token, count / length(tokens)}
    else
      {"", 0.0}
    end
  end

  @spec fetch_state(list) :: tuple
  def fetch_state(tokens), do: fetch_state(tokens, length(tokens))
  defp fetch_state(_tokens, id) when id == 0, do: {nil, nil}
  defp fetch_state([head | _tail], id) when id == 1, do: {nil, head}

  defp fetch_state(tokens, id) do
    tokens
    # fetch states by ids
    |> Enum.slice((id - 2)..(id - 1))
    |> List.to_tuple()
  end

  # Get tokens within agent
  defp fetch_tokens(state, pid), do: Agent.get(pid, &(&1[state] || []))

  # Build Markov chain model using tokens
  defp modelize(pid, tokens) do
    for {token, id} <- Enum.with_index(tokens) do
      tokens |> fetch_state(id) |> add_state(pid, token)
    end
  end

  # Add new state within agent
  defp add_state(state, pid, token) do
    Agent.update(pid, fn model ->
      current_state = model[state] || []
      Map.put(model, state, [token | current_state])
    end)
  end
end
