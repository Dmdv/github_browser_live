defmodule GithubBrowserLiveWeb.UserFavsLiveTest do
  use GithubBrowserLiveWeb.ConnCase

  import Phoenix.LiveViewTest
  import GithubBrowserLive.FavsFixtures

  @create_attrs %{repo_id: 42, user_id: 42}
  @update_attrs %{repo_id: 43, user_id: 43}
  @invalid_attrs %{repo_id: nil, user_id: nil}

  defp create_user_favs(_) do
    user_favs = user_favs_fixture()
    %{user_favs: user_favs}
  end

  describe "Index" do
    setup [:create_user_favs]

    test "lists all user_favs", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.user_favs_index_path(conn, :index))

      assert html =~ "Listing User favs"
    end

    test "saves new user_favs", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.user_favs_index_path(conn, :index))

      assert index_live |> element("a", "New User favs") |> render_click() =~
               "New User favs"

      assert_patch(index_live, Routes.user_favs_index_path(conn, :new))

      assert index_live
             |> form("#user_favs-form", user_favs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_favs-form", user_favs: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_favs_index_path(conn, :index))

      assert html =~ "User favs created successfully"
    end

    test "updates user_favs in listing", %{conn: conn, user_favs: user_favs} do
      {:ok, index_live, _html} = live(conn, Routes.user_favs_index_path(conn, :index))

      assert index_live |> element("#user_favs-#{user_favs.id} a", "Edit") |> render_click() =~
               "Edit User favs"

      assert_patch(index_live, Routes.user_favs_index_path(conn, :edit, user_favs))

      assert index_live
             |> form("#user_favs-form", user_favs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#user_favs-form", user_favs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_favs_index_path(conn, :index))

      assert html =~ "User favs updated successfully"
    end

    test "deletes user_favs in listing", %{conn: conn, user_favs: user_favs} do
      {:ok, index_live, _html} = live(conn, Routes.user_favs_index_path(conn, :index))

      assert index_live |> element("#user_favs-#{user_favs.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#user_favs-#{user_favs.id}")
    end
  end

  describe "Show" do
    setup [:create_user_favs]

    test "displays user_favs", %{conn: conn, user_favs: user_favs} do
      {:ok, _show_live, html} = live(conn, Routes.user_favs_show_path(conn, :show, user_favs))

      assert html =~ "Show User favs"
    end

    test "updates user_favs within modal", %{conn: conn, user_favs: user_favs} do
      {:ok, show_live, _html} = live(conn, Routes.user_favs_show_path(conn, :show, user_favs))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit User favs"

      assert_patch(show_live, Routes.user_favs_show_path(conn, :edit, user_favs))

      assert show_live
             |> form("#user_favs-form", user_favs: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#user_favs-form", user_favs: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.user_favs_show_path(conn, :show, user_favs))

      assert html =~ "User favs updated successfully"
    end
  end
end
