defmodule NpWeb.AlbumView do
  use NpWeb, :view
  alias Np.Resources.Album

  def no_links?(%Album{}=album) do
    album.links
    |> Map.from_struct
    |> Map.delete(:id)
    |> Map.values
    |> IO.inspect
    |> Enum.all?(&is_nil(&1))
    |> IO.inspect
  end

  def links() do
    %Np.Resources.Album.Links{}
    |> Map.from_struct
    |> Map.keys
    |> Enum.reject(fn k -> k == :id end)
  end
end
