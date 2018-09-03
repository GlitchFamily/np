results = YamlElixir.read_from_file!("priv/repo/seeds.yml")
          |> Enum.map(fn r ->
              Enum.map(r, fn {k,v} -> {String.to_atom(k), v} end)
              |> Enum.into(%{}) 
            end)
          |> Enum.map(&Map.put(&1, :links, %{}))


Enum.each results, fn album -> Np.Resources.create_album(album) end
