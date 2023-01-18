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
    Logger.info("Liked Event: Repo ID = #{id}, User ID: #{socket.assigns.current_user.email}")

    Favs.create_user_favs(%{:repo_id => id, :user_id => socket.assigns.current_user.id})

    repos = socket.assigns.repos
      |> Enum.map(fn repo ->
          if to_string(repo.id) == to_string(id) do
            %{repo | liked: :true}
          else
            repo
          end
        end)

    socket =
      socket
      |> assign(:repos, repos)
      |> put_flash(:info, "Added to favourites: #{id}")

    {:noreply, socket}
  end

  def handle_event("save", %{"id" => id, "action" => "unlike"}, socket) do
    Logger.info("Unliked Event: Repo ID = #{id}, User ID: #{socket.assigns.current_user.email}")

    flash =
      case Favs.delete_user_favs_by_userid_and_repo_id(socket.assigns.current_user.id, id) do
      :ok ->
        {:info, "Removed repo from favourites: #{id}"}
      :error ->
        {:warn, "Error: #{id}"}
      :not_found ->
        {:warn, "Repo not found: #{id}"}
    end

    repos =
      socket.assigns.repos
      |> Enum.map(fn repo ->
      if to_string(repo.id) == to_string(id) do
        %{repo | liked: :false}
      else
        repo
      end
    end)

    {t, message} = flash

    socket =
      socket
      |> assign(:repos, repos)
      |> put_flash(t, message)

    {:noreply, socket}

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