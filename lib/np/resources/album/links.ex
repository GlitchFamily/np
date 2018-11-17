defmodule Np.Resources.Album.Links do
  use Ecto.Schema

  embedded_schema do
    field :amazonmusic, :string
    field :applemusic, :string
    field :bandcamp, :string
    field :deezer, :string
    field :googleplay, :string
    field :soundcloud, :string
    field :spotify, :string
    field :youtube, :string
  end
end
