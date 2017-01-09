defmodule TicTacToe.Web.GameStateSerialiser do

  @separator ","
  @game_parsing_regex ~r{Board=(?<board>[^-]+)-Players=(?<players>.+)}

  def serialise(game) do
    serialised_players = serialise_players(game.players)
    serialised_board = serialise_board(game.board)
    "Board=" <> serialised_board <> "-Players=" <> serialised_players
  end

  def parse(serialised_game) do
    game_data = Regex.named_captures(@game_parsing_regex, serialised_game)
    board = parse_board(game_data["board"])
    players = parse_players(game_data["players"])
    %Game{board: board, players: players}
  end

  defp serialise_players({current_player, next_player}) do
    current_player_type = player_type(current_player)
    current_player_mark = Atom.to_string(current_player.mark)
    next_player_type = player_type(next_player)
    next_player_mark = Atom.to_string(next_player.mark)

    current_player_type <> @separator <> current_player_mark <> @separator <>
       next_player_type <> @separator <> next_player_mark
  end

  defp player_type(%Player.Human{}) do
    "Human"
  end

  defp player_type(%Player.MiniMax{}) do
    "MiniMax"
  end

  defp serialise_board(%Board{cells: cells}) do
    cells
      |> Enum.map(fn(cell) -> Atom.to_string(cell) end)
      |> Enum.join(@separator)
  end

  defp parse_board(serialised_board) do
    cells = serialised_board
              |> String.split(@separator)
              |> Enum.map(&(String.to_atom(&1)))
    %Board{cells: cells}
  end

  defp parse_players(serialised_players) do
    {player_one_type, player_one_mark, player_two_type, player_two_mark} =
      extract_players_data(serialised_players)
    current_player = parse_player(player_one_type, player_one_mark)
    next_player = parse_player(player_two_type, player_two_mark)
    {current_player, next_player}
  end

  def extract_players_data(serialised_players) do
    players_data = serialised_players |> String.split(@separator)
    player_one_type = players_data |> Enum.at(0)
    player_one_mark = players_data |> Enum.at(1)
    player_two_type = players_data |> Enum.at(2)
    player_two_mark = players_data |> Enum.at(3)
    {player_one_type, player_one_mark, player_two_type, player_two_mark}
  end

  defp parse_player(player_type, player_mark) do
    case player_type do
      "Human" -> %Player.Human{mark: String.to_atom(player_mark)}
      "MiniMax" -> %Player.MiniMax{mark: String.to_atom(player_mark)}
    end
  end

end
