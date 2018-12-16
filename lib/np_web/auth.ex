defmodule NpWeb.Auth do
  import Plug.Conn
  import Comeonin.Argon2, only: [checkpw: 2, dummy_checkpw: 0]
  import Phoenix.Controller
  require Logger
  alias NpWeb.Router.Helpers
  alias Np.Accounts.User
  alias Np.Repo

  def init(_) do
    nil
  end

  def call(conn, _) do
    user_id = get_session(conn, :user_id)
    user    = user_id && Repo.get(User, user_id)
    assign(conn, :current_user, user)
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in to see this :/")
      |> redirect(to: Helpers.page_path(conn, :index))
      |> halt()
    end
  end

  def login_username_password(conn, username, given_pass) do
    user = Repo.get_by(User, username: username)

    cond do
      user && checkpw(given_pass, user.password_hash) ->
        {:ok, login(conn, user)}
      user ->
        {:error, :unauthorized, conn}
      true ->
        dummy_checkpw()
        {:error, :not_found, conn}
    end
  end
end
