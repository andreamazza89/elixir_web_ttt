defmodule TicTacToe.Web.GameSessionPlug do
  use Plug.Builder

  def create_or_find_game(conn, _opts) do
    if session_has_game_state?(conn) do
      conn
    else
      conn |> create_default_game_state!()
    end
  end

  def get_game_state(conn) do
    get_from_session(conn, :game_state)
  end

  def update_game_state_with_move(conn, move) do
    move_as_integer = String.to_integer(move)
    old_game_state = get_game_state(conn)
    new_game_state = old_game_state |> Game.mark_cell_for_current_player(move_as_integer)

    conn |> set_in_session(:game_state, new_game_state)
  end

  def reset_game(conn) do
    conn |> create_default_game_state!()
  end

  defp session_has_game_state?(conn) do
    get_game_state(conn) !== nil #enforcing boolean conversion
  end

  defp create_default_game_state!(conn) do
    conn |> set_in_session(:game_state, %Game{})
  end

  defp get_from_session(conn, key) do
    conn |> fetch_session() |> get_session(key)
  end

  defp set_in_session(conn, key, value) do
    conn |> fetch_session() |> put_session(key, value)
  end

end
