defmodule IntegrationHumanVsComputerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  import TestHelpers
  alias TicTacToe.Web.GameSessionPlug

  test "Computer move is automatically added at computer's turn" do
    cpu_player = %Player.MiniMax{mark: :x}
    human_player = %Player.Human{mark: :o}
    response = get_req("/tictactoe/play")
                 |> add_session(%{game_state: %Game{players: {cpu_player, human_player}}})
                 |> call_router()

    updated_game = GameSessionPlug.get_game_state(response)
    assert response.status === 200
#the following relies on the fact that the minimax picks top left as first
#move, is that ok?
    assert updated_game.board === create_board([x: [1], o: []])
  end

end
