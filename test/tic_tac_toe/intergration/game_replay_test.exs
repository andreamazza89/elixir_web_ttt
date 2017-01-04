defmodule GameReplayTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  import TestHelpers
  alias TicTacToe.Web.GameSessionPlug

  test "resets the game" do
    game = create_game_with_human_players([x: [1,2,3], o: [4,5]], {:o, :x})
    response = post_req("/tictactoe/reset_game")
                 |> add_session(%{game_state: game})
                 |> call_router()
    updated_game = GameSessionPlug.get_game_state(response)

    assert response.status === 303
    assert get_resp_header(response, "location") === ["/tictactoe/play"]
    assert updated_game === create_game_with_human_players([x: [], o: []], {:x, :o})
  end

end
