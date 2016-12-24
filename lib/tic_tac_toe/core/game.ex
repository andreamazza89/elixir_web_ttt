defmodule Game do
  defstruct board: %Board{}, players: {%Player.Human{mark: :x}, %Player.Human{mark: :o}}

  def status(game = %Game{}) do
    case Board.status(game.board) do
      :draw -> :draw
      {:win, _} -> {:win, get_previous_player(game)}
      :incomplete -> :incomplete
    end
  end

  def draw?(game = %Game{}) do
    status(game) === :draw
  end

  def winner(game = %Game{}) do
    case status(game) do
      {:win, winner} -> winner
      _ -> nil
    end
  end

  def get_current_player(%Game{players: {current_player, _next_player}}) do
    current_player
  end

  def mark_cell_for_current_player(game = %Game{players: {current_player, next_player}}, cell_to_mark) do
    updated_board = Board.add_move(game.board, {cell_to_mark, current_player.mark})
    %Game{board: updated_board, players: {next_player, current_player}}
  end

  def make_next_move(game = %Game{}) do
    current_player = get_current_player(game)
    cell_to_mark = Player.get_next_move(current_player, game)
    Game.mark_cell_for_current_player(game, cell_to_mark)
  end

  defp get_previous_player(%Game{players: {_current_player, previous_player}}) do
    previous_player
  end

end
