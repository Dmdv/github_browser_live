defmodule GithubBrowserLive.GitHub do
  use HTTPoison.Base
  alias GithubBrowserLive.Favs
  require Logger

  def search_by_name_demo(""), do: []
  def search_by_name_demo(name) do
    list_demo()
    |> Enum.filter(&String.starts_with?(&1.name, name))
  end

  def search_by_name(nil, ""), do: []
  def search_by_name(_, ""), do: []

  def search_by_name(user_id, name) do
    repos_name_url(user_id, name)
  end

  def search_by_name(user_id, name, per_page) do
    repos_name_url(user_id, name, per_page)
  end

  def search_by_name(user_id, name, per_page, page) do
    repos_name_url(user_id, name, per_page, page)
  end

  def user(name) do
    get! "/users/#{name}"
  end

  def repos_name_url(user_id, name, per_page \\ 5, page \\ 1, order \\ "desc")
      when order in ["desc", "asc"] do
    repos(name, per_page, page, order)
    |> select_name_and_url(user_id)
  end

  def select_name_and_url(array, user_id) do
    array = array
    |> Enum.map(fn repo ->
      %{
        name: repo["name"],
        link: repo["html_url"],
        id: repo["id"],
        description: repo["description"],
        liked: :false,
        stars: repo["stargazers_count"]
      }
    end)

    favs =
      Favs.get_user_favs_by_user_id(user_id)
      |> reduce_to_map_with_field(&(&1.repo_id))

    Logger.info("Favs: #{inspect(favs)}")

    array
    |> Enum.map(fn repo ->
          if Map.has_key?(favs, repo.id) do
            %{repo | liked: :true}
          else
            repo
          end
        end)

#    select map from favs with key as user_id, value as repo_id do
#      array
#      |> Enum.map(fn repo ->
#        if repo.id == repo_id do
#          %{repo | liked: :true}
#        else
#          repo
#        end
#      end)
#    end

#    select map from favs with key <- array do
#      %{key | liked: favs.repo_id == key.id}
#    end

#    |> Enum.map(fn repo ->
#      case Favs.get_user_favs_by_userid_and_repo_id(repo.id, user_id) do
#        nil ->
#          repo
#        _ ->
#          Map.put(repo, :liked, :true)
#      end
#    end)
  end

  def reduce_to_map_with_field(array, func) do
    array
    |> Enum.reduce(%{}, fn item, acc ->
      Map.put(acc, func.(item), item)
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