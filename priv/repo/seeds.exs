alias Np.Accounts


results = YamlElixir.read_from_file!("priv/repo/seeds.yml")

Enum.each results, fn album -> Np.Resources.create_album(album) end

Accounts.create_user(%{username: "tekkonkinkreet", password: "concrete", email: "i_love@ani.me"})
