defmodule GithubBrowserLive.FavsTest do
  use GithubBrowserLive.DataCase

  alias GithubBrowserLive.Favs

  describe "user_favs" do
    alias GithubBrowserLive.Favs.UserFavs

    import GithubBrowserLive.FavsFixtures

    @invalid_attrs %{repo_id: nil}

    test "list_user_favs/0 returns all user_favs" do
      user_favs = user_favs_fixture()
      assert Favs.list_user_favs() == [user_favs]
    end

    test "get_user_favs!/1 returns the user_favs with given id" do
      user_favs = user_favs_fixture()
      assert Favs.get_user_favs!(user_favs.id) == user_favs
    end

    test "create_user_favs/1 with valid data creates a user_favs" do
      valid_attrs = %{repo_id: 42}

      assert {:ok, %UserFavs{} = user_favs} = Favs.create_user_favs(valid_attrs)
      assert user_favs.repo_id == 42
    end

    test "create_user_favs/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Favs.create_user_favs(@invalid_attrs)
    end

    test "update_user_favs/2 with valid data updates the user_favs" do
      user_favs = user_favs_fixture()
      update_attrs = %{repo_id: 43}

      assert {:ok, %UserFavs{} = user_favs} = Favs.update_user_favs(user_favs, update_attrs)
      assert user_favs.repo_id == 43
    end

    test "update_user_favs/2 with invalid data returns error changeset" do
      user_favs = user_favs_fixture()
      assert {:error, %Ecto.Changeset{}} = Favs.update_user_favs(user_favs, @invalid_attrs)
      assert user_favs == Favs.get_user_favs!(user_favs.id)
    end

    test "delete_user_favs/1 deletes the user_favs" do
      user_favs = user_favs_fixture()
      assert {:ok, %UserFavs{}} = Favs.delete_user_favs(user_favs)
      assert_raise Ecto.NoResultsError, fn -> Favs.get_user_favs!(user_favs.id) end
    end

    test "change_user_favs/1 returns a user_favs changeset" do
      user_favs = user_favs_fixture()
      assert %Ecto.Changeset{} = Favs.change_user_favs(user_favs)
    end
  end
end
