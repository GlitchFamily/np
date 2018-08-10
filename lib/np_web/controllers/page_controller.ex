defmodule NpWeb.PageController do
  use NpWeb, :controller

  def index(conn, _params) do
    conn = assign(conn, :is_home?, :true)
    render conn, "index.html"
  end
end
