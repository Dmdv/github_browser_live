defmodule GithubBrowserLive.FavsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GithubBrowserLive.Favs` context.
  """

  @doc """
  Generate a user_favs.
  """
  def user_favs_fixture(attrs \\ %{}) do
    {:ok, user_favs} =
      attrs
      |> Enum.into(%{
        repo_id: 42,
        user_id: 42
      })
      |> GithubBrowserLive.Favs.create_user_favs()

    user_favs
  end
end
