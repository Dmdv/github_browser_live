defmodule GithubBrowserLiveWeb.UserFavsLive.Show do
  use GithubBrowserLiveWeb, :live_view

  alias GithubBrowserLive.Favs

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:user_favs, Favs.get_user_favs!(id))}
  end

  defp page_title(:show), do: "Show User favs"
  defp page_title(:edit), do: "Edit User favs"
end
