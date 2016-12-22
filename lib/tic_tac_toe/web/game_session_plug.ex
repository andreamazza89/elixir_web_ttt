defmodule TicTacToe.Web.GameSessionPlug do
  use Plug.Builder


  def create_or_find_game(conn, _opts) do
    maybe_game_state = conn |> fetch_session() |> get_session(:game_state)
    if maybe_game_state, do: conn, else: conn |> fetch_session() |> put_session(:game_state, %Game{})
  end


  def get_game_state(conn) do
    conn |> fetch_session() |> get_session(:game_state)
  end

  def update_game_state_with_move(conn, move) do
    new_game_state = get_game_state(conn)
      |> Game.mark_cell_for_current_player(String.to_integer(move))

    conn |> fetch_session() |> put_session(:game_state, new_game_state)
  end

end
