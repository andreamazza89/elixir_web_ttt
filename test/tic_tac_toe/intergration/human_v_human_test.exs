defmodule IntegrationHumanVsHumanTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import WebHelpers
  import TestHelpers
  alias TicTacToe.Web.GameStateSerialiser

  test "displays the current game, with links to the available moves" do
    serialised_game_state = GameStateSerialiser.serialise(%Game{})
    response = get_req("/ttt/play/#{serialised_game_state}") |> call_router()

    assert response.status === 200
    assert response.resp_body =~ "It is x's turn, please pick a move"
    assert_resp_includes_serialised_move_buttons(response, (0..8), serialised_game_state)
  end

  test "only available moves can be made, board state is displayed" do
    game = create_game_with_human_players([x: [1], o: []], {:x, :o})
    serialised_game_state = GameStateSerialiser.serialise(game)
    response = get_req("/ttt/play/#{serialised_game_state}")
                 |> call_router()

    assert response.status === 200
    assert not(response.resp_body =~ serialised_move_button(0, serialised_game_state))
    assert_resp_includes_serialised_move_buttons(response, (1..8), serialised_game_state)
  end

  test "adds a move to the board, redirects to the play page" do
    serialised_game_state = GameStateSerialiser.serialise(%Game{})
    response = post_req("/ttt/moves/0/#{serialised_game_state}") |> call_router()

    updated_game = create_game_with_human_players([x: [1], o: []], {:o, :x})
    serialised_updated_game = GameStateSerialiser.serialise(updated_game)
    assert response.status === 303
    assert get_resp_header(response, "location") === ["/ttt/play/#{serialised_updated_game}"]
  end

  test "announces the winner when one exists" do
    game = create_game_with_human_players([x: [1,2,3], o: [4,5]], {:o, :x})
    serialised_game_state = GameStateSerialiser.serialise(game)
    response = get_req("/ttt/play/#{serialised_game_state}")
                 |> call_router()

    assert response.status === 200
    assert response.resp_body =~ "x has won!"
    assert not(response.resp_body =~ "turn")
  end

  test "announces a draw when applicable" do
    game = create_game_with_human_players([x: [1,2,6,7,9,], o: [3,4,5,8]], {:o, :x})
    serialised_game_state = GameStateSerialiser.serialise(game)
    response = get_req("/ttt/play/#{serialised_game_state}")
                 |> add_session(%{game_state: game})
                 |> call_router()

    assert response.status === 200
    assert response.resp_body =~ "It was a draw!"
    assert not(response.resp_body =~ "turn")
  end

end
