defmodule Np.Utils do

  require Logger

  def group_links(map) do
    links = Enum.filter(map, fn {k,_} -> String.starts_with?(k, "link_") end) |> Enum.into(%{}) |> atomify_map_keys
    nonlinks = Enum.reject(map, fn {k,_} -> String.starts_with?(k, "link_") end) |> Enum.into(%{}) |> atomify_map_keys
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

  def handle_cover(attrs) when is_map(attrs) do
    IO.inspect(attrs.cover, label: "Cover")
    cond do
      is_map(attrs.cover) ->
        cover     = attrs.cover
        extension = Path.extname(cover.filename)
        :ok = File.mkdir_p("priv/static/images/covers/#{attrs.artist}")
        new_path = "priv/static/images/covers/#{attrs.artist}/#{attrs.name}#{extension}"
        with {:ok, :exists} <- check_file_exists(cover.path),
             :ok            <- File.cp(cover.path, new_path),
             {:ok, :exists} <- check_file_exists(new_path) do
              %{attrs|cover: "/images/covers/#{attrs.artist}/#{attrs.name}#{extension}"}
        else
          {:notfound, path} ->
            raise("Path #{path} not found")
        end
      is_binary(attrs.cover) ->
        new_path = "/images/covers/" <> Path.basename(attrs.cover)
        %{attrs|cover: new_path}
      true -> 
        raise(ArgumentError, "Cover field not a map or a binary!!!: " <> inspect(attrs.cover))
    end
  end

  @spec check_file_exists(String.t) :: {:ok, :exists} | {:notfound, String.t}
  defp check_file_exists(path) do
    Logger.debug "Testing " <> path
    if File.exists?(path) do
      {:ok, :exists}
    else
      {:notfound, path}
    end
  end
end
