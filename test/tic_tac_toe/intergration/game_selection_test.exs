defmodule GameSelectionTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  import TestHelpers
  alias TicTacToe.Web.GameStateSerialiser

  test "shows the available game options" do
    response = get_req("/ttt/options")
                 |> call_router()

    assert response.status === 200
    assert response.resp_body =~ "Please select a game mode"
  end

  test "creates a new game of Human v MiniMax" do
    response = get_req("/ttt/new_game?mode=human_v_minimax_machine")
                 |> call_router()

    players = {%Player.Human{mark: :x}, %Player.MiniMax{mark: :o}}
    board = create_board([size: 3, x: [], o: []])
    game = %Game{players: players, board: board}
    serialised_game = GameStateSerialiser.serialise(game)

    assert response.status === 303
    assert get_resp_header(response, "location") === ["/ttt/play/#{serialised_game}"]
  end

end
