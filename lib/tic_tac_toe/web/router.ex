defmodule TicTacToe.Web.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get ("/tictactoe/play") do
    #game_id = somehow get or set game id in session
    #game_state = TicTacToe.Web.SessionManager.new_or_existing_game()
    #response_body = TicTacToe.Web.Views.render_game(game_state)
    response_body = "<p>It is x's turn, please pick a move</p> <form><button type=\"submit\" formaction=\"/tictactoe/moves/0\"></form>"
    conn |> put_resp_content_type("html") |> send_resp(200, response_body)
  end

end
