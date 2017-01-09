defmodule IntegrationHumanVsComputerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  alias TicTacToe.Web.GameStateSerialiser

  test "Computer move is automatically added at computer's turn" do
    cpu_player = %Player.MiniMax{mark: :x}
    human_player = %Player.Human{mark: :o}
    game = %Game{players: {cpu_player, human_player}}
    serialised_game = GameStateSerialiser.serialise(game)

    response = get_req("/ttt/computer_move/#{serialised_game}")
                 |> call_router()

    updated_game = Game.make_next_move(game)
    serialised_updated_game = GameStateSerialiser.serialise(updated_game)
    assert response.status === 303
    assert get_resp_header(response, "location") === ["/ttt/play/#{serialised_updated_game}"]
  end

end
