# GithubBrowserLive

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Create your database with `mix ecto.create`
  * Migrate your database with `mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Install Phoenix Application generator

```bash
mix archive.install hex phx_new
```

## Adding context and schema

  * Run `mix phx.gen.live Accounts User users name:string email:string bio:string number_of_pets:integer`
  * Create and migrate your database with `mix ecto.migrate`
  * Start Phoenix endpoint with `mix phx.server`

```bash
mix phx.gen.live Accounts User users name:string email:string bio:string number_of_pets:integer
```
```bash
mix ecto.migrate
```
```
❯❯❯ mix phx.gen.live Accounts User users name:string age:integer                                                                                                                                                                                                                                                                  (base)  master ✱
* creating lib/github_browser_live_web/live/user_live/show.ex
* creating lib/github_browser_live_web/live/user_live/index.ex
* creating lib/github_browser_live_web/live/user_live/form_component.ex
* creating lib/github_browser_live_web/live/user_live/form_component.html.heex
* creating lib/github_browser_live_web/live/user_live/index.html.heex
* creating lib/github_browser_live_web/live/user_live/show.html.heex
* creating test/github_browser_live_web/live/user_live_test.exs
* creating lib/github_browser_live_web/live/live_helpers.ex
* creating lib/github_browser_live/accounts/user.ex
* creating priv/repo/migrations/20230106053341_create_users.exs
* creating lib/github_browser_live/accounts.ex
* injecting lib/github_browser_live/accounts.ex
* creating test/github_browser_live/accounts_test.exs
* injecting test/github_browser_live/accounts_test.exs
* creating test/support/fixtures/accounts_fixtures.ex
* injecting test/support/fixtures/accounts_fixtures.ex
* injecting lib/github_browser_live_web.ex

Add the live routes to your browser scope in lib/github_browser_live_web/router.ex:

    live "/users", UserLive.Index, :index
    live "/users/new", UserLive.Index, :new
    live "/users/:id/edit", UserLive.Index, :edit

    live "/users/:id", UserLive.Show, :show
    live "/users/:id/show/edit", UserLive.Show, :edit


Remember to update your repository by running migrations:

    $ mix ecto.migrate
```

### Links
https://www.one-tab.com/page/RoPjtde4T46Zt55BBM-Z_Q
https://www.one-tab.com/page/JzAmhgz_QT-bZ-Oin-SiRw
