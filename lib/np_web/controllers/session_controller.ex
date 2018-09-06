defmodule NpWeb.SessionController do
  use NpWeb, :controller

  def new(conn, _) do
    render conn, "new.html"
  end

  def create(conn, %{"session" => %{"username" => user, "password" => password}}) do
    case NpWeb.Auth.login_username_password(conn, user, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "You're back!")
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> NpWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end
end
