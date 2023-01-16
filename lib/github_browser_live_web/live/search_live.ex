defmodule GithubBrowserLiveWeb.SearchLive do
  use GithubBrowserLiveWeb, :live_view
  alias GithubBrowserLive.GitHub
  alias GithubBrowserLive.Favs
  require Logger

  def mount(_params, session, socket) do
    socket = assign_defaults(session, socket)
    socket =
      socket
      |> assign(:name, "")
      |> assign(:repos, [])

    {:ok, socket}
  end

  def handle_event("save", %{"id" => id, "action" => "like"}, socket) do
    Logger.info("Liked: Repo ID = #{id}, User ID: #{socket.assigns.current_user.email}")

    Favs.create_user_favs(%{:repo_id => id, :user_id => socket.assigns.current_user.id})
    {:noreply, socket |> put_flash(:info, "Added to favourites: #{id}")}
  end

  def handle_event("save", %{"id" => id, "action" => "unlike"}, socket) do
    Logger.info("Unliked: Repo ID = #{id}, User ID: #{socket.assigns.current_user.email}")

    case Favs.delete_user_favs_by_userid_and_repo_id(id, socket.assigns.current_user.id) do
      {:ok, _} ->
        {:noreply, socket |> put_flash(:info, "Removed repo from favourites: #{id}")}
      {:error, _} ->
        {:noreply, socket |> put_flash(:warn, "Repo not found: #{id}")}
    end
  end

  def handle_event("github_search", %{"name" => name}, socket) do
    user_id = socket.assigns.current_user.id
    Logger.info("Searching repo: #{name}, User ID: #{user_id}")

    if name == nil do
      socket =
        socket
        |> assign(:name, "")
        |> assign(:repos, [])
      {:noreply, socket}
    else
      socket =
        socket
        |> assign(:name, name)
        |> assign(:repos, GitHub.search_by_name(user_id, name))
      {:noreply, socket}
    end
  end

  # Add a handle_info function to receive the message and clear flash after a 5 second delay

  def handle_info(:schedule_clear_flash, socket) do
    :timer.sleep(5000)
    {:noreply, clear_flash(socket)}
  end

end