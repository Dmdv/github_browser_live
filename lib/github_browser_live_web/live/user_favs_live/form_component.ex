defmodule GithubBrowserLiveWeb.UserFavsLive.FormComponent do
  use GithubBrowserLiveWeb, :live_component

  alias GithubBrowserLive.Favs

  @impl true
  def update(%{user_favs: user_favs} = assigns, socket) do
    changeset = Favs.change_user_favs(user_favs)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"user_favs" => user_favs_params}, socket) do
    changeset =
      socket.assigns.user_favs
      |> Favs.change_user_favs(user_favs_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user_favs" => user_favs_params}, socket) do
    save_user_favs(socket, socket.assigns.action, user_favs_params)
  end

  defp save_user_favs(socket, :edit, user_favs_params) do
    case Favs.update_user_favs(socket.assigns.user_favs, user_favs_params) do
      {:ok, _user_favs} ->
        {:noreply,
         socket
         |> put_flash(:info, "User favs updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user_favs(socket, :new, user_favs_params) do
    case Favs.create_user_favs(user_favs_params) do
      {:ok, _user_favs} ->
        {:noreply,
         socket
         |> put_flash(:info, "User favs created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
