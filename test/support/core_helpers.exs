defmodule TestHelpers do
  use ExUnit.Case
  use Plug.Test

  def create_game_with_human_players(board_layout, {player_1_mark, player_2_mark}) do
    board = create_board(board_layout)
    player_one = %Player.Human{mark: player_1_mark}
    player_two = %Player.Human{mark: player_2_mark}
    %Game{players: {player_one, player_two}, board: board}
  end

  def create_game_with_human_players(player_1_mark, player_2_mark) do
    create_game_with_human_players([x: [], o: []], {player_1_mark, player_2_mark})
  end

  def get_cell_at(index, game) do
    board = game.board
    Enum.at(board.cells, index)
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
