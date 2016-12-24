defmodule IntegreationHumanVsHumanTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  import TestHelpers
  import TicTacToe.Web.GameSessionPlug

  test "initialises the game to human v human, x to start" do
    response = get_req("/tictactoe/play")
                 |> add_session(%{})
                 |> call_router()

    assert response.status === 200
    assert response.resp_body =~ "It is x's turn, please pick a move"
    assert_response_includes_move_buttons(response, (0..8))
  end

  test "only available moves can be made, board state is displayed" do
    game = create_game_with_human_players([x: [1], o: []], {:x, :o})
    response = get_req("/tictactoe/play")
                 |> add_session(%{game_state: game})
                 |> call_router()

    assert response.status === 200
    assert not(response.resp_body =~ move_button(0))
    assert_response_includes_move_buttons(response, (1..8))
  end

  test "adds a move to the board, redirects to the play page" do
    response = post_req("/tictactoe/moves/0")
                 |> add_session(%{})
                 |> call_router()
    updated_game = get_game_state(response)


    assert response.status === 303
    assert get_resp_header(response, "location") === ["/tictactoe/play"]
    assert updated_game === create_game_with_human_players([x: [1], o: []], {:o, :x})
  end

end
