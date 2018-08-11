defmodule NpWeb.PageController do
  use NpWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def album(conn, _params) do
    render conn, "album.html"
  end
end
