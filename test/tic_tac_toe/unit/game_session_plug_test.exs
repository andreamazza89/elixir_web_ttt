defmodule TicTacToe.Web.GameSessionPlugTest do
  use ExUnit.Case, async: true
  import TestHelpers
  import WebHelpers
  use Plug.Test
  import TicTacToe.Web.GameSessionPlug

  test "creates a default game for a new session" do
    conn = get_req("/")
             |> add_session(%{})
             |> create_or_find_game([])

    assert get_session(conn, :game_state) === %Game{}
  end

  test "does not alter an existing game" do
    conn = get_req("/")
             |> add_session(%{game_state: "existing game double"})
             |> create_or_find_game([])

    assert get_session(conn, :game_state) === "existing game double"
  end

  test "retrieves an existing game state" do
    conn = get_req("/")
             |> add_session(%{game_state: "existing game double"})
    game_state = get_game_state(conn)

    assert game_state === "existing game double"
  end

  test "updates the session's game state with the given move" do
    game = %Game{board: create_board(x: [], o: [])}
    conn = get_req("/")
             |> add_session(%{game_state: game})
             |> update_game_state_with_move("0")
    game_state = get_game_state(conn)

    assert game_state.board === create_board(x: [1], o: [])
  end

end
