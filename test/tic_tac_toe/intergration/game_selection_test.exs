defmodule GameSelectionTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  import TestHelpers
  import TicTacToe.Web.GameSessionPlug

  test "shows the available game options" do
    response = get_req("/tictactoe/options")
                 |> call_router()

    assert response.status === 200
    assert response.resp_body =~ "Please select a game mode"
  end

  test "creates a new game of Human v MiniMax" do
    response = post_req("/tictactoe/new_game", %{"mode"=>"human_v_minimax_machine"})
                 |> add_session(%{})
                 |> call_router()

    game = get_game_state(response)
    players = {%Player.Human{mark: :x}, %Player.MiniMax{mark: :o}}
    board = create_board([size: 3, x: [], o: []])

    assert response.status === 303
    assert get_resp_header(response, "location") === ["/tictactoe/play"]
    assert game === %Game{players: players, board: board}
  end

end
