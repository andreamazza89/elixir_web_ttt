defmodule TicTacToe.Web.GamePresenter do

  def render_game(game) do
    cells = game.board.cells
    {current_player, _next_player} = game.players
    EEx.eval_file("templates/game.eex", [current_player: current_player, cells: cells])
  end

end
