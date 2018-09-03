defmodule NpWeb.AlbumView do
  use NpWeb, :view
  alias Np.Resources.Album

  def has_links?(%Album{}=album) do
    album.links
    |> Map.from_struct
    |> Map.delete(:id)
    |> Map.values
    |> IO.inspect
    |> Enum.all?(&!is_nil(&1))
  end
end
