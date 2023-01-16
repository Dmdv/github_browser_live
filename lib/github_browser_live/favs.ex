defmodule GithubBrowserLive.Favs do
  @moduledoc """
  The Favs context.
  """

  import Ecto.Query, warn: false
  alias GithubBrowserLive.Repo

  alias GithubBrowserLive.Favs.UserFavs

  @doc """
  Returns the list of user_favs.

  ## Examples

      iex> list_user_favs()
      [%UserFavs{}, ...]

  """
  def list_user_favs do
    Repo.all(UserFavs)
  end

  @doc """
  Gets a single user_favs.

  Raises `Ecto.NoResultsError` if the User favs does not exist.

  ## Examples

      iex> get_user_favs!(123)
      %UserFavs{}

      iex> get_user_favs!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user_favs!(id), do: Repo.get!(UserFavs, id)

  @doc """
  Creates a user_favs.

  ## Examples

      iex> create_user_favs(%{field: value})
      {:ok, %UserFavs{}}

      iex> create_user_favs(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user_favs(attrs \\ %{}) do
    %UserFavs{}
    |> UserFavs.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user_favs.

  ## Examples

      iex> update_user_favs(user_favs, %{field: new_value})
      {:ok, %UserFavs{}}

      iex> update_user_favs(user_favs, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user_favs(%UserFavs{} = user_favs, attrs) do
    user_favs
    |> UserFavs.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user_favs.

  ## Examples

      iex> delete_user_favs(user_favs)
      {:ok, %UserFavs{}}

      iex> delete_user_favs(user_favs)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user_favs(%UserFavs{} = user_favs) do
    Repo.delete(user_favs)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user_favs changes.

  ## Examples

      iex> change_user_favs(user_favs)
      %Ecto.Changeset{data: %UserFavs{}}

  """
  def change_user_favs(%UserFavs{} = user_favs, attrs \\ %{}) do
    UserFavs.changeset(user_favs, attrs)
  end
end
