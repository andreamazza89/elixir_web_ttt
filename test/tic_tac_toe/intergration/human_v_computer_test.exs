defmodule IntegrationHumanVsComputerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  alias TicTacToe.Web.GameStateStringifier

  test "Computer move is automatically added at computer's turn" do
    cpu_player = %Player.MiniMax{mark: :x}
    human_player = %Player.Human{mark: :o}
    game = %Game{players: {cpu_player, human_player}}
    stringy_game = GameStateStringifier.stringify(game)

    response = get_req("/ttt/computer_move/#{stringy_game}")
                 |> call_router()

    updated_game = Game.make_next_move(game)
    stringy_updated_game = GameStateStringifier.stringify(updated_game)
    assert response.status === 303
    assert get_resp_header(response, "location") === ["/ttt/play/#{stringy_updated_game}"]
  end

end
