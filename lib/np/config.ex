defmodule Np.Config do
  use Mix.Releases.Config.Provider

  @impl Provider
  def init(_) do
    port            = get_env("PORT")
    hostname        = get_env("HOSTNAME")
    secret_key_base = get_env("SECRET_KEY_BASE")
    database_url    = get_env("DATABASE_URL")

    Application.put_env(:np, NpWeb.Endpoint, [
      http: [:inet6, port: port || 4000],
      url: [host: hostname, port: 80],
      secret_key_base: secret_key_base
      ])

    Application.put_env(:np, Np.Repo, [
      url: database_url,
      pool_size: 10
    ])
  end

  defp get_env(var) do
    case System.get_env(var) do
      nil -> 
        raise(ArgumentError, "Variable #{var} absent from environment")
        System.stop(1)
      value -> value
    end
  end
end
