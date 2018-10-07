results = YamlElixir.read_from_file!("priv/repo/seeds.yml", atoms: true)

Enum.each results, fn album -> Np.Resources.create_album(album) end
