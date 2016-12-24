defmodule Board do
  defstruct cells: [:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]

  def create_board(size) do
    largest_index = (size * size) - 1
    cells = Enum.map((0..largest_index), fn(_) -> :empty end)
    %Board{cells: cells}
  end

  def add_move(board = %Board{}, {cell_index, players_mark}) do
    old_cells = board.cells
    new_cells = List.replace_at(old_cells, cell_index, players_mark)
    %Board{board | cells: new_cells}
  end

  def width(board = %Board{}) do
    number_of_cells = length(board.cells)
    :math.sqrt(number_of_cells) |> round
  end

  def available_moves(%Board{cells: cells}) do
    cells |> Enum.with_index |> Enum.reduce([], &add_empty_cell_to_list/2)
  end

  defp add_empty_cell_to_list({cell_status, cell_index}, available_moves) do
    if (cell_status === :empty) do
      List.insert_at(available_moves, -1, cell_index)
    else
      available_moves
    end
  end

  def status(board = %Board{}) do
    cells = board.cells
    rows_cols_diags = get_rows(cells) ++ get_columns(cells) ++ get_diagonals(cells)
    cond do
      any_winning_collection?(rows_cols_diags, :x) -> {:win, :x}
      any_winning_collection?(rows_cols_diags, :o) -> {:win, :o}
      all_cells_have_a_mark?(rows_cols_diags) -> :draw
      true -> :incomplete
    end
  end

  def empty?(board = %Board{}) do
    Enum.all?(board.cells, &(&1 === :empty))
  end

  def indexed_rows(board = %Board{}) do
    board_width = width(board)
    board.cells |> Enum.with_index() |> Enum.chunk(board_width)
  end

  defp any_winning_collection?(rows_cols_diags, mark) do
    cell_has_mark? = fn(cell) -> cell === mark end
    all_cells_same_mark? = fn(collection) -> Enum.all?(collection, cell_has_mark?) end
    Enum.any?(rows_cols_diags, all_cells_same_mark?)
  end

  defp all_cells_have_a_mark?(rows_cols_diags) do
    Enum.all?(List.flatten(rows_cols_diags), fn(cell) -> cell !== :empty end)
  end

  defp get_rows(cells) do
    board_width = width(%Board{cells: cells})
    Enum.chunk(cells, board_width)
  end

  defp get_columns(cells) do
    board_width = width(%Board{cells: cells})
    do_get_columns(cells, [], board_width)
  end

  defp do_get_columns([], columns, 0) do
    columns
  end

  defp do_get_columns(cells, columns, current_column) do
    this_column = Enum.take_every(cells, current_column)
    remaining_cells = Enum.drop_every(cells, current_column)
    do_get_columns(remaining_cells, columns ++ [this_column], current_column - 1)
  end

   defp get_diagonals(cells) do
    board_width = width(%Board{cells: cells})
    rows = get_rows(cells)
    reverse_rows = Enum.reverse(rows)
    downwards = do_get_diagonals(rows, [], board_width)
    upwards = do_get_diagonals(reverse_rows, [], board_width)
    [downwards, upwards]
  end

  defp do_get_diagonals(_rows, diagonal, 0) do
    diagonal
  end

  defp do_get_diagonals(rows, diagonal, current_column) do
    zero_adjusted_column = current_column - 1
    cell_to_add = rows |> Enum.at(zero_adjusted_column) |> Enum.at(zero_adjusted_column)
    do_get_diagonals(rows, diagonal ++ [cell_to_add], current_column - 1 )
  end

end
