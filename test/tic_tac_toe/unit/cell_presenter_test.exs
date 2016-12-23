defmodule CellPresenterTest do
  use ExUnit.Case

  test "knows if a cell is empty" do
    indexed_cell = {:empty, 0}
    assert TicTacToe.Web.CellPresenter.is_empty?(indexed_cell) === true
  end

  test "knows if a cell is not empty" do
    indexed_cell = {:x, 0}
    assert TicTacToe.Web.CellPresenter.is_empty?(indexed_cell) === false
  end

  test "knows the cell's mark, example one" do
    indexed_cell = {:x, 0}
    assert TicTacToe.Web.CellPresenter.mark(indexed_cell) === :x
  end

  test "knows the cell's mark, example two" do
    indexed_cell = {:o, 0}
    assert TicTacToe.Web.CellPresenter.mark(indexed_cell) === :o
  end

  test "knows the cell's index, example one" do
    indexed_cell = {:x, 0}
    assert TicTacToe.Web.CellPresenter.index(indexed_cell) === 0
  end

  test "knows the cell's index, example two" do
    indexed_cell = {:x, 5}
    assert TicTacToe.Web.CellPresenter.index(indexed_cell) === 5
  end

end
