defmodule TicTacToe.Web.ViewManager do

  def render_game(game) do
    rows = game.board |> Board.indexed_rows
    {current_player, _next_player} = game.players

    EEx.eval_file("templates/game.eex", [current_player: current_player, rows: rows])
  end

end
