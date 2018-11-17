defmodule NpWeb.PageControllerTest do
  use NpWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Handpicked Albums"
  end
end
