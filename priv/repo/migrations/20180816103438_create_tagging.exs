defmodule Np.Repo.Migrations.CreateTagging do
  use Ecto.Migration

  def change do
    create table(:tagging, primary_key: false) do
      add :album_id, references(:albums)
      add :tag_id,  references(:tags)
    end
  end
end
