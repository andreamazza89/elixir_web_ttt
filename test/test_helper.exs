ExUnit.start()

defmodule TestHelpers do
  use ExUnit.Case
  import ExUnit.CaptureIO

  def assert_console_output_matches(regex, action) do
    assert Regex.match?(regex, capture_io(action)) 
  end

  def get_cell_at(index, game) do
    board = game.board
    Enum.at(board.cells, index)
  end

  def create_human_player_with_moves([moves: moves, mark: mark, ui: ui]) do
    moves_stream = create_input_stream(moves)
    %Player.Human{io: {ui, moves_stream}, mark: mark}
  end

  def create_human_player_with_moves([moves: moves, mark: mark]) do
    moves_stream = create_input_stream(moves)
    %Player.Human{io: {UI.Console, moves_stream}, mark: mark}
  end

  def create_human_player_with_moves([moves: moves, ui: ui]) do
    create_human_player_with_moves(moves: moves, mark: :x, ui: ui)
  end

  def create_human_player_with_moves([ui: ui]) do
    create_human_player_with_moves(moves: "A1\n", mark: :x, ui: ui)
  end

  def create_input_stream(lines) do
    {:ok, input_stream} = StringIO.open(lines) 
    input_stream
  end

  def create_board([size: size, x: cross_locations, o: noughts_locations]) do
    cross_locations = subtract_one_from_all_elements(cross_locations)
    noughts_locations = subtract_one_from_all_elements(noughts_locations)
    largest_index = (size * size) - 1
    cells = Enum.map((0..largest_index), fn(_) -> :empty end)
              |> update_multiple_nodes(cross_locations, :x) 
              |> update_multiple_nodes(noughts_locations, :o)
    %Board{cells: cells}
  end

  def create_board([x: cross_locations, o: noughts_locations]) do
    create_board([size: 3, x: cross_locations, o: noughts_locations])
  end

  defp subtract_one_from_all_elements(list) do
    Enum.map(list, &(&1 - 1))
  end

  defp update_multiple_nodes(list, [first_udpate_index | other_indexes], value) do
    updated_list = List.update_at(list, first_udpate_index, fn(_) -> value end)
    update_multiple_nodes(updated_list, other_indexes, value)
  end

  defp update_multiple_nodes(list, [], _) do
    list
  end

end
