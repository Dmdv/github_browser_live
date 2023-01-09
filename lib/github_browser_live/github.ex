defmodule GithubBrowserLive.GitHub do
  def search_by_name(""), do: []

  def search_by_name(name) do
    list_repos()
    |> Enum.filter(&String.starts_with?(&1.name, name))
  end

  def list_repos do
    [
      %{name: "Berlin Brandenburg", link: "BER"},
      %{name: "Berlin Schönefeld", link: "SXF"},
      %{name: "Berlin Tegel", link: "TXL"},
      %{name: "Bremen", link: "BRE"},
      %{name: "Dortmund", link: "DTM"},
      %{name: "Dertmund", link: "DEM"},
    ]
  end
end