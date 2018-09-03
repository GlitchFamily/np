results = YamlElixir.read_from_file!("priv/repo/seeds.yml", atoms: true)
          |> Enum.map(fn r ->
              Enum.map(r, fn {k,v} -> {String.to_atom(k), v} end)
              |> Enum.into(%{}) 
            end)


Enum.each results, fn album -> Np.Resources.create_album(album) end
