defmodule Np.Repo do
  use Ecto.Repo,
    otp_app: :np,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 6
end
