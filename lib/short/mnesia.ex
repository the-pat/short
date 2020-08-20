defmodule Short.Mnesia do
  def setup!(table, nodes \\ [node()]) do
    Memento.stop()
    Memento.Schema.create(nodes)
    Memento.start()

    Memento.Table.create!(table, disc_copies: nodes)
  end
end
