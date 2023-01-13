defmodule GithubBrowserLiveWeb.SharedComponents do
  def card(assigns \\ %{}, do: block), do: render_template("card.html", assigns, block)
  def card_header(assigns \\ %{}, do: block), do: render_template("card_header.html", assigns, block)
  def card_body(assigns \\ %{}, do: block), do: render_template("card_body.html", assigns, block)

  defp render_template(template, assigns, block) do
    assigns =
      assigns
      |> Map.new()
      |> Map.put(:inner_content, block)

    GithubBrowserLiveWeb.SharedView.render(template, assigns)
  end
end