defmodule Np.Repo.Migrations.CreateAlbums do
  use Ecto.Migration

  def change do
    create table(:albums) do
      add :name, :string
      add :cover, :string
      add :artist, :string
      add :links, :map
      timestamps()
    end

  end
end