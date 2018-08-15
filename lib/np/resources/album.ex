defmodule Np.Resources.Album do
  use Ecto.Schema
  alias Np.Resources.Tag
  alias Np.Repo
  import Ecto.Changeset


  schema "albums" do
    field :artist, :string
    field :cover, :string
    field :name, :string
    
    embeds_one :links, Links do
      field :spotify, :string
      field :youtube, :string
      field :bandcamp, :string
      field :soundcloud, :string
      field :applemusic, :string
      field :googleplay, :string
    end

    many_to_many :tags, Tag,
      join_through: "tagging"

    timestamps()
  end

  @doc false
  def changeset(album, attrs) do
    tags = parse_tags(attrs.tags)

    album
    |> cast(attrs, [:name, :cover, :artist])
    |> validate_required([:name, :cover, :artist])
    |> put_assoc(:tags, tags) 
  end

  @spec parse_tags([String.t]|String.t) :: [String.t]
  def parse_tags(tags) when is_list(tags),   do: tags |> Enum.map(&get_or_insert_tag(&1))
  def parse_tags(tags) when is_binary(tags), do: tags |> String.split(",") |> Enum.map(&String.strip(&1)) |> parse_tags

  def get_or_insert_tag(name), do: Repo.get_by(Tag, name: name) || Repo.insert!(%Tag{name: name})
end
