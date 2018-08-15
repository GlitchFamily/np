defmodule NpWeb.PageController do
  use NpWeb, :controller

  def index(conn, _params) do
    albums = Np.Resources.get_albums
    render conn, "index.html", albums: albums
  end

  def album(conn, _params) do
    render conn, "album.html"
  end
end
