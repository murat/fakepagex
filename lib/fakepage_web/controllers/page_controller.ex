defmodule FakepageWeb.PageController do
  use FakepageWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
