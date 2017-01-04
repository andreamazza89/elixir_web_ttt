defmodule TicTacToe.Web.Router do
  use Plug.Router
  import TicTacToe.Web.GameSessionPlug
  alias TicTacToe.Web.GameSessionPlug
  alias TicTacToe.Web.View

  @secret String.duplicate("abcdef0123456789", 8)

  plug Plug.Session, store: :cookie, key: "_my_app_session",
                     encryption_salt: "cookie store encryption salt",
                     signing_salt: "cookie store signing salt",
                     key_length: 64, log: :debug

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug Plug.Static, at: "/public", from: :elixir_web_ttt
  plug :put_secret_key_base
  plug Plug.Logger
  plug :match
  plug :create_or_find_game
  plug :dispatch

  get ("/tictactoe/options") do
    response_body = View.game_options()
    conn |> put_resp_content_type("html") |> resp(200, response_body)
  end

  get ("/tictactoe/play") do
    game_state = conn |> GameSessionPlug.get_game_state()
    response_body = View.render_game(game_state)
    conn |> put_resp_content_type("html") |> resp(200, response_body)
  end

  get ("/tictactoe/computer_move") do
    conn |> GameSessionPlug.make_next_move() |> redirect_to("/tictactoe/play")
  end

  post ("/tictactoe/moves/:move") do
    conn |> GameSessionPlug.update_game_state_with_move(move) |> redirect_to("/tictactoe/play")
  end

  post ("/tictactoe/new_game") do
###### I wonder if creating the game options should be delegated to an Optionsparser module? ####
    mode = String.to_atom(conn.body_params["mode"])
    game_options = [mode: mode]
#################################################################################################
    conn |> create_game_state_in_session(game_options) |> redirect_to("/tictactoe/play")
  end

  post ("/tictactoe/reset_game") do
    conn |> GameSessionPlug.reset_game() |> redirect_to("/tictactoe/play")
  end

  match _ do
    conn |> resp(404, "Oops, something went wrong, maybe try /tictactoe/play")
  end

  defp redirect_to(conn, to, message \\ "you are being redirected") do
    conn |> put_resp_header("location", to) |> resp(303, message)
  end

  defp put_secret_key_base(conn, _) do
    put_in conn.secret_key_base, @secret
  end

end
