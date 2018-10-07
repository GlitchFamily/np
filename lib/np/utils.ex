defmodule Np.Utils do

  def group_links(map) do
    links = Enum.filter(map, fn {k,_} -> String.starts_with?(k, "link_") end) |> Enum.into(%{}) |> atomify_map_keys
    nonlinks = Enum.reject(map, fn {k,v} -> String.starts_with?(k, "link_") end) |> Enum.into(%{}) |> atomify_map_keys
    Map.put(nonlinks, :links, links)
  end

  def atomify_map_keys(map) do
    for {key, val} <- map, into: %{} do 
      {transform(key), val}
    end
  end

  defp transform(key) when is_binary(key), do: String.to_atom(key)
  defp transform(key),                       do: key

  def mkhash() do
    UUID.uuid1
    |> String.split("-")
    |> hd
  end
end
