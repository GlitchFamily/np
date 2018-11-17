results = YamlElixir.read_from_file!("priv/repo/seeds.yml")

Enum.each results, fn album -> Np.Resources.create_album(album) end
