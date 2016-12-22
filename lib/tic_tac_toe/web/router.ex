defmodule TicTacToe.Web.Router do
  use Plug.Router
  import TicTacToe.Web.GameSessionPlug
  import TicTacToe.Web.GamePresenter

  plug Plug.Logger
  plug :match
  plug :create_or_find_game
  plug :dispatch

  get ("/tictactoe/play") do
    game = get_game_state(conn)
    response_body = render_game(game)
    conn |> put_resp_content_type("html") |> send_resp(200, response_body)
  end

  post ("/tictactoe/moves/:move") do
    conn
      |> update_game_state_with_move(move)
      |> redirect_to("/tictactoe/play")
  end

  defp redirect_to(conn, to, message \\ "you are being redirected") do
    conn |> put_resp_header("location", to) |> resp(303, message)
  end

end
