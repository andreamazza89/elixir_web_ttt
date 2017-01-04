defmodule TicTacToe.Web.CellPresenter do

  def cell_occupied?({cell_mark, _index}) do
    cell_mark !== :empty
  end

  def mark({cell_mark, _index}) do
    case cell_mark do
      :empty -> ""
      _ -> cell_mark
    end
  end

  def index({_cell_mark, index}) do
    index
  end

end
