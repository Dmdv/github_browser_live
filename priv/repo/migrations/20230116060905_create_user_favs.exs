defmodule GithubBrowserLive.Repo.Migrations.CreateUserFavs do
  use Ecto.Migration

  def change do
    create table(:user_favs) do
      add :user_id, :integer
      add :repo_id, :integer

      timestamps()
    end
  end
end
