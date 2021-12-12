defmodule FakepageWeb.PageController do
  use FakepageWeb, :controller

  alias Fakepage.Data.{Crawler, Model, Generator}

  def index(conn, _params) do
    render(conn, "index.html", %{"sentences" => []})
  end

  def create(
        conn,
        %{"url" => url, "text" => text, "sentences" => sentences}
      ) do
    source =
      if is_nil(text) || text == "" do
        Crawler.crawl(url)
      else
        text
      end

    {:ok, model} = Model.start_link()

    # populate Markov model with the source
    model = Model.populate(model, source)

    length =
      case sentences do
        "" ->
          15

        _ ->
          String.to_integer(sentences)
      end

    sentences =
      1..length
      |> Enum.map(fn _ ->
        model |> Generator.create_sentence()
      end)

    render(conn, "index.html", %{"sentences" => sentences})
  end
end
