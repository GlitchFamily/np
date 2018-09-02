defmodule Np.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :cover, :string
      add :artist, :string
      add :hash, :string
      add :links, :map
      add :slug, :string, null: false

      timestamps()
    end

  end
end
