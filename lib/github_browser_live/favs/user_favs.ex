defmodule GithubBrowserLive.Favs.UserFavs do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_favs" do
    field :repo_id, :integer
    field :user_id, :integer

    timestamps()
  end

  @doc false
  def changeset(user_favs, attrs) do
    user_favs
    |> cast(attrs, [:user_id, :repo_id])
    |> validate_required([:user_id, :repo_id])
  end
end
