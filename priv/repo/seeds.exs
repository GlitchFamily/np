alias Np.Accounts.User
alias Np.Repo

results = YamlElixir.read_from_file!("priv/repo/seeds.yml", atoms: true)
          |> Enum.map(fn r ->
              Enum.map(r, fn {k,v} -> {String.to_atom(k), v} end)
              |> Enum.into(%{}) 
            end)


Enum.each results, fn album -> Np.Resources.create_album(album) end
Repo.insert! %User{username: "lili", email: "hiya@lili.um", password_hash: Comeonin.Argon2.hashpwsalt("xptdr23")}
