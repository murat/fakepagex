defmodule FakepageWeb.PageController do
  use FakepageWeb, :controller

  alias Fakepage.Data.{Crawler, Model, Generator}

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def create(
        conn,
        %{"url" => url, "text" => text, "sentences" => sentences}
      ) do
    source_text =
      if is_nil(text) || text == "" do
        Crawler.crawl(url)
      else
        text
      end

    {:ok, model} = Model.start_link()
    IO.inspect(model)

    # populate Markov model with the source
    model = Model.populate(model, source_text)

    length =
      case sentences do
        "" ->
          15

        _ ->
          String.to_integer(sentences)
      end

    article =
      1..length
      |> Enum.map(fn _ ->
        model |> Generator.create_sentence()
      end)
      |> Enum.join("</p><p>")

    render(conn, "index.html", %{"article" => "<p>#{article}</p>"})
  end
end
