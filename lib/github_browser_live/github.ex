defmodule GithubBrowserLive.GitHub do
  use HTTPoison.Base

  def search_by_name_demo(""), do: []
  def search_by_name_demo(name) do
    list_demo()
    |> Enum.filter(&String.starts_with?(&1.name, name))
  end

  def search_by_name(""), do: []

  def search_by_name(name) do
    repos_name_url(name)
  end

  def search_by_name(name, per_page) do
    repos_name_url(name, per_page)
  end

  def search_by_name(name, per_page, page) do
    repos_name_url(name, per_page, page)
  end

  def user(name) do
    get! "/users/#{name}"
  end

  def repos_name_url(name, per_page \\ 5, page \\ 1, order \\ "desc")
      when order in ["desc", "asc"] do
    repos(name, per_page, page, order)
    |> select_name_and_url
  end

  def select_name_and_url(array) do
    array
    |> Enum.map(fn repo ->
      %{
        name: repo["name"],
        link: repo["html_url"],
      }
    end)
  end

  def repos(name, per_page \\ 5, page \\ 1, order \\ "desc")
          when order in ["desc", "asc"] do
    get!("/search/repositories?q=#{name}&per_page=#{per_page}&page=#{page}&order=#{order}", [{"Accept", "application/vnd.github+json"}]).body[:items]
  end

  def process_request_url(url) do
    "https://api.github.com" <> url
  end

  def process_response_body(body) do
    body
    |> Poison.decode!
    |> dict_to_atoms
  end

  def list_demo do
    [
      %{name: "Berlin Brandenburg", link: "BER"},
      %{name: "Berlin Schönefeld", link: "SXF"},
      %{name: "Berlin Tegel", link: "TXL"},
      %{name: "Bremen", link: "BRE"},
      %{name: "Dortmund", link: "DTM"},
      %{name: "Dertmund", link: "DEM"},
    ]
  end

  ## Helpers

  def dict_to_atoms(dict) do
    Enum.map(dict, fn {k, v} -> {String.to_atom(k), v} end)
  end

end