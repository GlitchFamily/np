defmodule Np.Repo.Migrations.UniqueIndexes do
  use Ecto.Migration

  def change do
    create index(:tags, [:name], unique: true)
    create index(:albums, [:artist, :name], unique: true)
  end
end
