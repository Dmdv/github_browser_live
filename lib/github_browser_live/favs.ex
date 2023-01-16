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

  def get_user_favs_by_user_id(user_id) do
    Repo.all(UserFavs, user_id: user_id)
  end

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
  Deletes all user_favs by user_id and repo_id.
  """
  def delete_user_favs_by_userid_and_repo_id(user_id, repo_id) do
    case Repo.delete_all(user_favorites(user_id, repo_id)) do
      {1, nil} -> :ok
      {0, nil} -> :not_found
      {_, :error} = error -> error
    end
  end

  @doc """
  Gets all tokens for the given user for the given contexts.
  """
  def user_favorites(user_id, repo_id) do
    from f in UserFavs, where: f.user_id == ^user_id and f.repo_id == ^repo_id
  end

#  def select_all_user_favs_by_userid(user_id) do
#    Repo.all(from f in UserFavs, where: f.user_id == ^user_id)
#  end

  def count_user_favs(repo_id, user_id) do
    user_favorites(repo_id, user_id)
    |> Repo.aggregate(:count, :id)
  end

  def is_favorite?(user_id, repo_id) do
    case Repo.one(user_favorites(user_id, repo_id)) do
      nil -> false
      _ -> true
    end
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
