defmodule Short.Links.Link do
  use Memento.Table,
    attributes: [:hash, :url],
    index: [:url]
end
