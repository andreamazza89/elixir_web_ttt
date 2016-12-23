ExUnit.start()

defmodule TestHelpers do
  use ExUnit.Case

  def move_button(move) do
    "/tictactoe/moves/#{move}"
  end

  def create_game_with_human_players(player_one_mark, player_two_mark) do
    player_one = %Player.Human{mark: player_one_mark}
    player_two = %Player.Human{mark: player_two_mark}
    %Game{players: {player_one, player_two}}
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
