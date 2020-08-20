defmodule Short.Links do
  @hash_id_length 8

  alias Short.Links.Link

  def list_links() do
    Memento.transaction(fn ->
      Memento.Query.all(Link)
    end)
  end

  def get_link!(id) do
    Memento.transaction!(fn ->
      Memento.Query.read(Link, id)
    end)
  end

  def get_link_by_url!(url) do
    Memento.transaction!(fn ->
      Memento.Query.select(Link, {:==, :url, url})
    end)
  end

  def create_link(url) do
    case get_link_by_url!(url) do
      [%Link{} = link] ->
        {:ok, link}

      _ ->
        hash =
          @hash_id_length
          |> :crypto.strong_rand_bytes()
          |> Base.url_encode64()
          |> binary_part(0, @hash_id_length)

        link = %Link{url: url, hash: hash}

        Memento.transaction(fn ->
          Memento.Query.write(link)
        end)
    end
  end

  def delete_link(%Link{} = link) do
    Memento.transaction(fn ->
      Memento.Query.delete_record(link)
    end)
  end
end
