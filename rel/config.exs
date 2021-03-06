# Import all plugins from `rel/plugins`
# They can then be used by adding `plugin MyPlugin` to
# either an environment, or release definition, where
# `MyPlugin` is the name of the plugin module.
~w(rel plugins *.exs)
|> Path.join()
|> Path.wildcard()
|> Enum.map(&Code.eval_file(&1))

use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :default,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env()

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/config/distillery.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  # If you are running Phoenix, you should make sure that
  # server: true is set and the code reloader is disabled,
  # even in dev mode.
  # It is recommended that you build with MIX_ENV=prod and pass
  # the --env flag to Distillery explicitly if you want to use
  # dev mode.
  set dev_mode: true
  set include_erts: false
  set cookie: :"3F0cKl06>nxj,3A^t%|fzF`:7L)0b:V!R@I_Yuk}@8R[W;|D6E_P,^8?73Ti,I_!"
end

environment :prod do
  set include_erts: true
  set include_src: false
  set cookie: :"9QGTbA{}.>W)2j[*i[EgO``adTu)Z(|i>5}~Lu8a[lv`!3M9^cJ(w6<$=Sz~AIt^"
  set vm_args: "rel/vm.args"
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default

release :np do
  set config_providers: [
    Np.Config,
    # {Mix.Releases.Config.Providers.Elixir, ["${RELEASE_ROOT_DIR}/config/config.exs"]},
    # {Mix.Releases.Config.Providers.Elixir, ["${RELEASE_ROOT_DIR}/config/prod.exs"]},
  ]
  set overlays: [
    # {:copy, "config", "config"},
    {:copy, "priv", "priv"},
    {:copy, "assets/static/images", "assets/static/images"}

  ]
  set commands: [
    migrate: "rel/commands/migrate.sh",
    seed: "rel/commands/seed.sh",
  ]
  set version: current_version(:np)
  set applications: [
    :runtime_tools,
    :elixir_make
  ]
end

