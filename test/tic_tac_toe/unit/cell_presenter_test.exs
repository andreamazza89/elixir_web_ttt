defmodule CellPresenterTest do
  use ExUnit.Case
  import TicTacToe.Web.CellPresenter

  test "knows if a cell is empty" do
    indexed_cell = {:empty, 0}
    assert is_empty?(indexed_cell) === true
  end

  test "knows if a cell is not empty" do
    indexed_cell = {:x, 0}
    assert is_empty?(indexed_cell) === false
  end

  test "knows the cell's mark, example one" do
    indexed_cell = {:x, 0}
    assert mark(indexed_cell) === :x
  end

  test "knows the cell's mark, example two" do
    indexed_cell = {:o, 0}
    assert mark(indexed_cell) === :o
  end

  test "knows the cell's mark, empty example" do
    indexed_cell = {:empty, 0}
    assert mark(indexed_cell) === ""
  end

  test "knows the cell's index, example one" do
    indexed_cell = {:x, 0}
    assert index(indexed_cell) === 0
  end

  test "knows the cell's index, example two" do
    indexed_cell = {:x, 5}
    assert index(indexed_cell) === 5
  end

end
