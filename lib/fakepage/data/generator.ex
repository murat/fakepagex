defmodule Fakepage.Data.Generator do
  alias Fakepage.Data.Model

  @treshold 0.75

  @spec create_sentence(pid) :: binary
  def create_sentence(pid) do
    {sentence, prob} = build_sentence(pid)

    # Create new sentence or convert builded based on treshold value
    if prob >= @treshold do
      sentence |> Enum.join(" ") |> String.capitalize()
    else
      create_sentence(pid)
    end
  end

  # Sentence is complete when it have enough length
  # or when punctuation ends a sentence
  defp complete?(tokens) do
    # IO.inspect(tokens)

    length(tokens) > 3 && Regex.match?(~r/[\!\?\.]\z/, List.last(tokens))
  end

  defp build_sentence(pid), do: build_sentence(pid, [], 0.0, 0.0)

  defp build_sentence(pid, tokens, prob_acc, new_tokens) do
    # Fetch Markov model state through agent
    {token, prob} = tokens |> Model.fetch_state() |> Model.fetch_token(pid)

    case complete?(tokens) do
      true ->
        score =
          case new_tokens == 0 do
            true -> 1.0
            # count new probability for this word
            _ -> prob_acc / new_tokens
          end

        {tokens, score}

      _ ->
        # Concat sentence with new token and try to continue
        build_sentence(pid, tokens ++ [token], prob + prob_acc, new_tokens + 1)
    end
  end
end
