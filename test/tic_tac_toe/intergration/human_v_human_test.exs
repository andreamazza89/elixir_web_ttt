defmodule IntegreationHumanVsHumanTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import TestHelpers
  import TicTacToe.Web.GameSessionPlug

  @options TicTacToe.Web.Router.init([])

  test "initialises the game to human v human, x to start" do
    response = conn(:get, "/tictactoe/play")
      |> init_test_session(%{})
      |> TicTacToe.Web.Router.call(@options)

    assert response.status === 200
    assert response.resp_body =~ "It is x's turn, please pick a move"
    assert response.resp_body =~ move_button(0)
    assert response.resp_body =~ move_button(1)
    assert response.resp_body =~ move_button(2)
    assert response.resp_body =~ move_button(3)
    assert response.resp_body =~ move_button(4)
    assert response.resp_body =~ move_button(5)
    assert response.resp_body =~ move_button(6)
    assert response.resp_body =~ move_button(7)
    assert response.resp_body =~ move_button(8)
  end

@tag :wip
  test "only available moves can be made" do
    response = conn(:get, "/tictactoe/play")
      |> init_test_session(%{game_state: %Game{board: create_board([x: [1], o: []]), players: {%Player.Human{mark: :o}, %Player.Human{mark: :x}}}})
      |> TicTacToe.Web.Router.call(@options)

    assert response.status === 200
    assert not(response.resp_body =~ move_button(0))
  end

  test "adds a move to the board, redirects to the play page" do
    response = conn(:post, "/tictactoe/moves/0")
                  |> init_test_session(%{})
                  |> TicTacToe.Web.Router.call(@options)
    updated_game = get_game_state(response)


    assert response.status === 303
    assert get_resp_header(response, "location") === ["/tictactoe/play"]
    assert updated_game === %Game{board: create_board(x: [1], o: []), players: {%Player.Human{mark: :o}, %Player.Human{mark: :x}}}
  end

end
