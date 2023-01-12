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
        |> assign(:repos, GitHub.search_by_name(name))
      {:noreply, socket}
    end
  end

  # Add a handle_info function to receive the message and clear flash after a 5 second delay

  def handle_info(:schedule_clear_flash, socket) do
    :timer.sleep(5000)
    {:noreply, clear_flash(socket)}
  end

end