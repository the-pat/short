defmodule ShortWeb.LinkController do
  use ShortWeb, :controller

  alias Short.Links
  alias Short.Links.Link

  action_fallback ShortWeb.FallbackController

  def index(conn, _params) do
    {:ok, links} = Links.list_links()

    render(conn, "index.json", links: links)
  end

  def create(conn, %{"link" => link_params}) do
    %{"url" => url} = link_params

    with {:ok, %Link{} = link} <- Links.create_link(url) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.link_path(conn, :show, link.hash))
      |> render("show.json", link: link)
    end
  end

  def show(conn, %{"id" => id}) do
    link = Links.get_link!(id)
    render(conn, "show.json", link: link)
  end

  def delete(conn, %{"id" => id}) do
    link = Links.get_link!(id)

    with {:ok, :ok} <- Links.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end

  def get_and_redirect(conn, %{"id" => id}) do
    url =
      id
      |> Links.get_link!()
      |> Map.get(:url)

    redirect(conn, external: url)
  end
end
