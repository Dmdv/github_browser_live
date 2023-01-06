defmodule GithubBrowserLive.Repo do
  use Ecto.Repo,
    otp_app: :github_browser_live,
    adapter: Ecto.Adapters.Postgres
end
