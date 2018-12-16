defmodule Np.Config do
  use Mix.Releases.Config.Provider

  @impl Provider
  def init(_) do
    port            = System.get_env("PORT")
    hostname        = System.get_env("HOSTNAME")
    secret_key_base = System.get_env("SECRET_KEY_BASE")
    database_url    = System.get_env("DATABASE_URL")

    Application.put_env(:np, NpWeb.Endpoint, [
      http: [:inet6, port: port || 4000],
      url: [host: hostname, port: 80],
      secret_key_base: secret_key_base
      ])

    Application.put_env(:np, Np.Repo, [
      url: database_url,
      show_sensitive_data_on_connection_error: true,
      pool_size: 10
    ])
  end
end
