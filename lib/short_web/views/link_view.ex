defmodule ShortWeb.LinkView do
  use ShortWeb, :view
  alias ShortWeb.LinkView

  def render("index.json", %{links: links}) do
    %{data: render_many(links, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    %{data: render_one(link, LinkView, "link.json")}
  end

  def render("link.json", %{link: link}) do
    %{
      hash: link.hash,
      url: link.url
    }
  end
end
