defmodule GithubBrowserLiveWeb.SearchLive do
  use GithubBrowserLiveWeb, :live_view
  alias GithubBrowserLive.GitHub

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:name, "")
      |> assign(:repos, [])

    {:ok, socket}
  end

  def handle_event(
        "github_search",
        %{"name" => name},
        socket
      ) do

    socket =
      socket
      |> assign(:name, name)
      |> assign(:repos, GitHub.search_by_name(name))

    {:noreply, socket}
  end
end