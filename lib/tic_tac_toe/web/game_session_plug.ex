defmodule TicTacToe.Web.GameSessionPlug do
  use Plug.Builder

  @secret String.duplicate("abcdef0123456789", 8)

  plug Plug.Session, store: :cookie,
                     key: "_my_app_session",
                     encryption_salt: "cookie store encryption salt",
                     signing_salt: "cookie store signing salt",
                     key_length: 64,
                     log: :debug,
                     secret_key_base: @secret


  def create_or_find_game(conn, _opts) do
    maybe_game_state = get_game_state(conn)
    if maybe_game_state, do: conn, else: conn |> put_session(:game_state, %Game{})
  end


  def get_game_state(conn) do
    conn |> fetch_session() |> get_session(:game_state)
  end

  def update_game_state_with_move(conn, move) do
    new_game_state = get_game_state(conn)
      |> Game.mark_cell_for_current_player(String.to_integer(move))

    conn |> put_session(:game_state, new_game_state)
  end

end
