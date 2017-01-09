defmodule TicTacToe.Web.Router do
  use Plug.Router
  alias TicTacToe.Web.GameStateSerialiser
  alias TicTacToe.Web.View

  plug Plug.Parsers, parsers: [:urlencoded, :multipart]
  plug Plug.Static, at: "/public", from: :elixir_web_ttt
  plug Plug.Logger
  plug :match
  plug :dispatch

  get ("/") do
    conn |> redirect_to("/ttt/options")
  end

  get ("/ttt/options") do
    response_body = View.game_options()
    conn |> put_resp_content_type("html") |> resp(200, response_body)
  end

  get ("ttt/play/:serialised_game_state") do
    game_state = GameStateSerialiser.parse(serialised_game_state)
    response_body = View.render_game(game_state, serialised_game_state)
    conn |> put_resp_content_type("html") |> resp(200, response_body)
  end

  get ("/ttt/computer_move/:serialised_game_state") do
    old_game_state = GameStateSerialiser.parse(serialised_game_state)
    new_game_state = Game.make_next_move(old_game_state)
    serialised_new_game_state = GameStateSerialiser.serialise(new_game_state)
    conn |> redirect_to("/ttt/play/#{serialised_new_game_state}")
  end

  post ("/ttt/moves/:move/:serialised_game_state") do
    old_game_state = GameStateSerialiser.parse(serialised_game_state)
    new_game_state = Game.mark_cell_for_current_player(old_game_state, String.to_integer(move))
    serialised_new_game_state = GameStateSerialiser.serialise(new_game_state)
    conn |> redirect_to("/ttt/play/#{serialised_new_game_state}")
  end

  post ("/ttt/new_game") do
    mode = String.to_atom(conn.body_params["mode"])
    game = GameFactory.create_game([board_size: 3, mode: mode, swap_order: false])
    serialised_game = GameStateSerialiser.serialise(game)
    conn |> redirect_to("/ttt/play/#{serialised_game}")
  end

  match _ do
    conn |> resp(404, "Oops, something went wrong, maybe try /ttt/options")
  end

  defp redirect_to(conn, to, message \\ "you are being redirected") do
    conn |> put_resp_header("location", to) |> resp(303, message)
  end

end
