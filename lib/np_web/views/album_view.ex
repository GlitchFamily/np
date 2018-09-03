defmodule NpWeb.AlbumView do
  use NpWeb, :view
  alias Np.Resources.Album

  def has_links?(%Album{}=album) do
    al.links
    |> Map.from_struct
    |> Map.delete(:id)
    |> Map.values
    |> Enum.all(&!is_nil(&1))
  end
end
