defmodule GithubBrowserLive.Repo.Migrations.CreateUserFavs do
  use Ecto.Migration

  def change do
    create table(:user_favs) do
      add :repo_id, :integer
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:user_favs, [:user_id])
  end
end
