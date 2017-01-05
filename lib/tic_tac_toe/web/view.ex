defmodule TicTacToe.Web.View do

  def render_game(game, stringy_game_state) do
    rows = game.board |> Board.indexed_rows
    {current_player, _next_player} = game.players
    draw? = Game.draw?(game)
    winner = Game.winner(game)

    EEx.eval_file("templates/stringy_game.eex", [current_player: current_player, rows: rows,
                                         winner: winner, draw: draw?,
                                         computer_goes_next?: computer_goes_next?(game),
                                         stringy_game_state: stringy_game_state])
  end

  def stringified_game_options do
    EEx.eval_file("templates/stringy_game_options.eex")
  end

  defp computer_goes_next?(game) do
    current_player = Game.get_current_player(game)
    game_not_over?(game) and computer_player?(current_player)
  end

  defp computer_player?(%Player.MiniMax{}) do
    true
  end

  defp computer_player?(_) do
    false
  end

  defp game_not_over?(game) do
    Game.status(game) === :incomplete
  end

end
