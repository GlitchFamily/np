defmodule NpWeb.PageController do
  use NpWeb, :controller

  def page(conn, %{"number" => offset}) do
    page = Np.Resources.list_albums(limit: 6, offset: offset)
    case offset do
      "1" ->
        render conn, "home.html", albums: page.entries, page: page
      _ ->
        render conn, "catalog.html", albums: page.entries, page: page
    end
  end

  def index(conn, _params) do
    page = Np.Resources.list_albums(limit: 6, offset: 1)
    render conn, "home.html", albums: page.entries, page: page
  end

  def album(conn, _params) do
    render conn, "album.html"
  end
end
