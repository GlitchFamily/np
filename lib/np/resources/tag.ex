defmodule Np.Resources.Tag do
  use Ecto.Schema
  alias Np.Resources.Album
  import Ecto.Changeset


  schema "tags" do
    field :name, :string

    many_to_many :albums, Album,
                 join_through: "tagging"

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
