defmodule GithubBrowserLive.Favs.UserFavs do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_favs" do
    field :repo_id, :integer
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(user_favs, attrs) do
    user_favs
    |> cast(attrs, [:repo_id])
    |> validate_required([:repo_id])
  end
end
