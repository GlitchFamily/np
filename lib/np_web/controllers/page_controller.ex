defmodule NpWeb.PageController do
  use NpWeb, :controller

  def page(conn, %{"number" => offset}) do
    page = Np.Resources.list_albums(limit: 6, offset: offset)
    render conn, "index.html", albums: page.entries, page: page
  end

  def index(conn, _params) do
    page = Np.Resources.list_albums(limit: 6, offset: 1)
    render conn, "index.html", albums: page.entries, page: page
  end

  def album(conn, _params) do
    render conn, "album.html"
  end
end
