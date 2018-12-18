defmodule Np.Resources.Album do
  alias Np.Repo
  alias Np.Resources.Album.Links
  alias Np.Resources.Tag
  import Ecto.Changeset
  require Logger
  use Ecto.Schema

  schema "albums" do
    field :artist, :string
    field :cover, :string
    field :name, :string
    field :hash, :string
    field :slug, :string

    embeds_one :links, Links, on_replace: :delete

    many_to_many :tags, Tag,
      join_through: "tagging",
      on_replace: :delete,
      on_delete: :delete_all

    timestamps()
  end


  @doc false
  def changeset(album, attrs) do
    album
    |> cast(attrs, [:name, :cover, :artist, :hash])
    |> cast_embed(:links, with: &links_changeset/2)
    |> validate_required([:name, :cover, :artist, :hash])
  end

  def update_changeset(%__MODULE__{}=album, attrs \\ %{}) do
    Logger.info "Updating #{attrs.name}"
    tags = parse_tags(attrs.tags)
    links = attrs.links

    album
    |> changeset(attrs)
    |> put_change(:links, links)
    |> put_assoc(:tags, tags)
  end

  def register_changeset(%__MODULE__{}=album, attrs \\ %{}) do
    Logger.info "Registering #{attrs.name}"
    tags = parse_tags(attrs.tags)
    links = attrs.links

    album
    |> changeset(attrs)
    |> put_change(:links, links)
    |> put_assoc(:tags, tags)
    |> put_slug
  end

  defp links_changeset(struct, attrs) do
    struct
    |> cast(attrs, [:amazonmusic, :applemusic, :bandcamp, :deezer, :googleplay, :soundcloud, :spotify, :youtube])
  end

  def put_slug(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{name: name}} ->
        put_change(changeset, :slug, slugify(name))
      _ ->
        changeset
    end
  end

  defp slugify(name), do: Slugger.slugify_downcase(name)

  @spec parse_tags([String.t]|String.t) :: [String.t]
  def parse_tags(tags) when is_list(tags),   do: tags |> Enum.map(&get_or_insert_tag(&1))
  def parse_tags(tags) when is_binary(tags), do: tags |> String.split(",") |> Enum.map(&String.trim(&1)) |> parse_tags


  def get_or_insert_tag(name), do: Repo.get_by(Tag, name: name) || Repo.insert!(%Tag{name: name})

end

defimpl Enumerable, for: [Np.Resources.Album.Links, Plug.Upload] do

	def sanitize(map) do
    map
    |> Map.delete(:id)
    |> Map.delete(:__struct__)
	end

  def count(map) do
    {:ok, map |> sanitize |> map_size}
  end

  def member?(map, {key, value}) do
    {:ok, match?(%{^key => ^value}, sanitize(map))}
  end

  def member?(_map, _other) do
    {:ok, false}
  end

  def slice(map) do
    {:ok, map_size(sanitize(map)), &Enumerable.List.slice(:maps.to_list(sanitize(map)), &1, &2)}
  end

  def reduce(map, acc, fun) do
	  reduce_list(:maps.to_list(sanitize(map)), acc, fun)
	end

  defp reduce_list(_list, {:halt, acc}, _fun), do: {:halted, acc}
  defp reduce_list(list, {:suspend, acc}, fun), do: {:suspended, acc, &reduce_list(list, &1, fun)}
  defp reduce_list([], {:cont, acc}, _fun), do: {:done, acc}
  defp reduce_list([head | tail], {:cont, acc}, fun), do: reduce_list(tail, fun.(head, acc), fun)
end
