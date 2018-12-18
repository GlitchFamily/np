defmodule Np.Config do
  use Mix.Releases.Config.Provider

  @impl Provider
  def init(_) do
    port            = get_env("PORT")
    hostname        = get_env("HOSTNAME")
    secret_key_base = get_env("SECRET_KEY_BASE")
    database_url    = get_env("DATABASE_URL")

    conf = [endpoint: Application.get_env(:np, NpWeb.Endpoint)]
    new_conf = [endpoint: [http: [:inet6, port: port || 4000],
                           url: [host: hostname, port: 80],
                           secret_key_base: secret_key_base
                          ]]

    Application.put_env(:np, NpWeb.Endpoint, merge(conf, new_conf) |> Keyword.get(:endpoint))

    Application.put_env(:np, Np.Repo, [
      url: database_url,
      pool_size: 10
    ])

    static_path = get_env("NP_STATIC_PATH")
    Application.put_env(:np, :static_path, static_path)
  end

  defp get_env(var) do
    case System.get_env(var) do
      nil -> 
        raise(ArgumentError, "Variable #{var} absent from environment")
        System.stop(1)
      value -> value
    end
  end

  def merge(config1, config2) do
    Keyword.merge(config1, config2, fn _, app1, app2 ->
      Keyword.merge(app1, app2, &deep_merge/3)
    end)
  end

  defp deep_merge(_key, value1, value2) do
    if Keyword.keyword?(value1) and Keyword.keyword?(value2) do
      Keyword.merge(value1, value2, &deep_merge/3)
    else
      value2
    end
  end
end
