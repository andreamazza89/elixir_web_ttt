defmodule TicTacToe.Web.GameStateSerialiser do

  def serialise(game) do
    {:ok, serialised_game} = JSON.encode(game)
    serialised_game
  end

  def parse(serialised_game) do
    {:ok, map_of_the_game} = JSON.decode(serialised_game)
    players = parse_players(map_of_the_game["players"])
    board = parse_board(map_of_the_game["board"])
    %Game{board: board, players: players}
  end

  defp parse_players(players) do
    player_one = parse_player(Enum.at(players, 0))
    player_two = parse_player(Enum.at(players, 1))
    {player_one, player_two}
  end

  defp parse_player(player) do
    type = player["__struct__"]
    mark = player["mark"]
    struct(String.to_atom(type), %{mark: String.to_atom(mark)})
  end

  defp parse_board(board) do
    serialised_cells = board["cells"]
    atom_cells = for cell <- serialised_cells, do: String.to_atom(cell)
    %Board{cells: atom_cells}
  end

end
