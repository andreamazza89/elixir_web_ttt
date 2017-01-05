defmodule TicTacToe.Web.Router do
  use Plug.Router
  alias TicTacToe.Web.GameStateStringifier
  alias TicTacToe.Web.View

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug Plug.Static, at: "/public", from: :elixir_web_ttt
  plug Plug.Logger
  plug :match
  plug :dispatch

  get ("/ttt/options") do
    response_body = View.stringified_game_options()
    conn |> put_resp_content_type("html") |> resp(200, response_body)
  end

  get ("ttt/play/:stringy_game_state") do
    game_state = GameStateStringifier.parse(stringy_game_state)
    response_body = View.render_game(game_state, stringy_game_state)
    conn |> put_resp_content_type("html") |> resp(200, response_body)
  end

  get ("/ttt/computer_move/:stringy_game_state") do
    old_game_state = GameStateStringifier.parse(stringy_game_state)
    new_game_state = Game.make_next_move(old_game_state)
    stringy_new_game_state = GameStateStringifier.stringify(new_game_state)
    conn |> redirect_to("/ttt/play/#{stringy_new_game_state}")
  end

  post ("/ttt/moves/:move/:stringy_game_state") do
    old_game_state = GameStateStringifier.parse(stringy_game_state)
    new_game_state = Game.mark_cell_for_current_player(old_game_state, String.to_integer(move))
    stringy_new_game_state = GameStateStringifier.stringify(new_game_state)
    conn |> redirect_to("/ttt/play/#{stringy_new_game_state}")
  end

  post ("/ttt/new_game") do
###### I wonder if creating the game options should be delegated to an Optionsparser module? ##################
###### feels like an overkill right now, but might feel the need for it if adding game-swap, board size... ####
    mode = String.to_atom(conn.body_params["mode"])
    game = GameFactory.create_game([board_size: 3, mode: mode, swap_order: false])
    stringy_game = GameStateStringifier.stringify(game)
#################################################################################################
    conn |> redirect_to("/ttt/play/#{stringy_game}")
  end

  match _ do
    conn |> resp(404, "Oops, something went wrong, maybe try /tictactoe/play")
  end

  defp redirect_to(conn, to, message \\ "you are being redirected") do
    conn |> put_resp_header("location", to) |> resp(303, message)
  end

end
