defmodule Np.ResourcesTest do
  use Np.DataCase

  alias Np.Resources

  describe "albums" do
    alias Np.Resources.Album

    @valid_attrs %{artist: "some artist", cover: "some cover", name: "some name"}
    @update_attrs %{artist: "some updated artist", cover: "some updated cover", name: "some updated name"}
    @invalid_attrs %{artist: nil, cover: nil, name: nil}

    def album_fixture(attrs \\ %{}) do
      {:ok, album} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_album()

      album
    end

    test "list_albums/0 returns all albums" do
      album = album_fixture()
      assert Resources.list_albums() == [album]
    end

    test "get_album!/1 returns the album with given id" do
      album = album_fixture()
      assert Resources.get_album!(album.id) == album
    end

    test "create_album/1 with valid data creates a album" do
      assert {:ok, %Album{} = album} = Resources.create_album(@valid_attrs)
      assert album.artist == "some artist"
      assert album.cover == "some cover"
      assert album.name == "some name"
    end

    test "create_album/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_album(@invalid_attrs)
    end

    test "update_album/2 with valid data updates the album" do
      album = album_fixture()
      assert {:ok, %Album{} = album} = Resources.update_album(album, @update_attrs)
      
      assert album.artist == "some updated artist"
      assert album.cover == "some updated cover"
      assert album.name == "some updated name"
    end

    test "update_album/2 with invalid data returns error changeset" do
      album = album_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_album(album, @invalid_attrs)
      assert album == Resources.get_album!(album.id)
    end

    test "delete_album/1 deletes the album" do
      album = album_fixture()
      assert {:ok, %Album{}} = Resources.delete_album(album)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_album!(album.id) end
    end

    test "change_album/1 returns a album changeset" do
      album = album_fixture()
      assert %Ecto.Changeset{} = Resources.change_album(album)
    end
  end

  describe "tags" do
    alias Np.Resources.Tag

    @valid_attrs %{name: "some name"}
    @update_attrs %{name: "some updated name"}
    @invalid_attrs %{name: nil}

    def tag_fixture(attrs \\ %{}) do
      {:ok, tag} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Resources.create_tag()

      tag
    end

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Resources.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Resources.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      assert {:ok, %Tag{} = tag} = Resources.create_tag(@valid_attrs)
      assert tag.name == "some name"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Resources.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{} = tag} = Resources.update_tag(tag, @update_attrs)
      
      assert tag.name == "some updated name"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Resources.update_tag(tag, @invalid_attrs)
      assert tag == Resources.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Resources.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Resources.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Resources.change_tag(tag)
    end
  end
end
