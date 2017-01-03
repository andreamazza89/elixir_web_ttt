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
    assert response.resp_body =~ "Swap playing order?"
  end

  test "creates a new game with swapped players" do
    response = post_req("/tictactoe/new_game?swap_order=true")
                 |> add_session(%{})
                 |> call_router()
    game = get_game_state(response)

    assert response.status === 303
    assert get_resp_header(response, "location") === ["/tictactoe/play"]
    assert game === create_game_with_human_players([x: [], o: []], {:o, :x})
  end

end
