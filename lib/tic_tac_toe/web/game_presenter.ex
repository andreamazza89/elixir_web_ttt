defmodule TicTacToe.Web.GamePresenter do

  def render_game(game) do
    board_width = Board.width(game.board)
    rows = game.board.cells |> Enum.with_index |> Enum.chunk(board_width)
    {current_player, _next_player} = game.players

    EEx.eval_file("templates/game.eex", [current_player: current_player, rows: rows])
  end

end
