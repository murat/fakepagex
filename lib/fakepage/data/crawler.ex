defmodule Fakepage.Data.Crawler do
  @moduledoc """
  This module is responsible for crawling the given web article URL.
  """

  @spec crawl(binary) :: binary | [binary, ...]
  def crawl(url) do
    with {:ok, %{body: body}} <- HTTPoison.get(url, [], follow_redirect: true),
         {:ok, document} <- Floki.parse_document(body),
         paragraphs <- Floki.find(document, "article p") do
      paragraphs
      |> Enum.map(fn x ->
        Floki.text(x)
      end)
      |> Enum.join("")
    else
      _ -> [url]
    end
  end
end
