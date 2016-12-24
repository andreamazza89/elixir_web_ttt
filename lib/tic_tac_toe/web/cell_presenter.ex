defmodule TicTacToe.Web.CellPresenter do

  def is_empty?({cell_mark, _index}) do
    cell_mark === :empty
  end

  def mark({cell_mark, _index}) do
    cell_mark
  end

  def index({_cell_mark, index}) do
    index
  end

end
