defmodule Fakepage.Data.Tokenizer do
  @moduledoc """
  This module splits the given text into words.
  """

  @spec tokenize(binary) :: list
  def tokenize(text) do
    text
    |> String.downcase()
    |> String.split(~r{\n}, trim: true)
    |> Enum.map(&String.split/1)
  end
end
