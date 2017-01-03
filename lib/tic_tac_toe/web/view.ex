defmodule TicTacToe.Web.View do

  def render_game(game) do
    rows = game.board |> Board.indexed_rows
    {current_player, _next_player} = game.players
    draw? = Game.draw?(game)
    winner = Game.winner(game)

    EEx.eval_file("templates/game.eex", [current_player: current_player, rows: rows,
                                         winner: winner, draw: draw?])
  end

end
