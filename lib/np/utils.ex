defmodule Np.Utils do

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
