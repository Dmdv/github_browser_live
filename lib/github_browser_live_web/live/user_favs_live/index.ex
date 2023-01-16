defmodule GithubBrowserLiveWeb.UserFavsLive.Index do
  use GithubBrowserLiveWeb, :live_view

  alias GithubBrowserLive.Favs
  alias GithubBrowserLive.Favs.UserFavs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :user_favs_collection, list_user_favs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit User favs")
    |> assign(:user_favs, Favs.get_user_favs!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New User favs")
    |> assign(:user_favs, %UserFavs{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing User favs")
    |> assign(:user_favs, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    user_favs = Favs.get_user_favs!(id)
    {:ok, _} = Favs.delete_user_favs(user_favs)

    {:noreply, assign(socket, :user_favs_collection, list_user_favs())}
  end

  defp list_user_favs do
    Favs.list_user_favs()
  end
end
