defmodule TicTacToe.Web.CellPresenter do

  def is_empty?({cell_mark, index}) do
    cell_mark === :empty
  end

  def mark({cell_mark, index}) do
    cell_mark
  end

  def index({cell_mark, index}) do
    index
  end

end
