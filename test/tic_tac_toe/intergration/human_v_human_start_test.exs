defmodule GameControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test
  import TestHelpers

  @options TicTacToe.Web.Router.init([])

  test "renders the play page with human v human, x to start" do
    response = conn(:get, "/tictactoe/play") |> TicTacToe.Web.Router.call(@options)

    assert response.status === 200
    assert response.resp_body =~ "It is x's turn, please pick a move"
    assert response.resp_body =~ move_button(0)
    #assert response.resp_body =~ move_button(1)
    #assert response.resp_body =~ move_button(2)
    #assert response.resp_body =~ move_button(3)
    #assert response.resp_body =~ move_button(4)
    #assert response.resp_body =~ move_button(5)
    #assert response.resp_body =~ move_button(6)
    #assert response.resp_body =~ move_button(7)
    #assert response.resp_body =~ move_button(8)
  end

  test "adds a move to the board, updates available moves" do
    conn(:get, "/tictactoe/play") |> TicTacToe.Web.Router.call(@options)
    post_move = conn(:post, "/tictactoe/moves/0") |> TicTacToe.Web.Router.call(@options)
    response = conn(:get, "/tictactoe/play") |> TicTacToe.Web.Router.call(@options)

    assert post_move.status === 303
    assert response.status === 200
    assert response.resp_body =~ "It is o's turn, please pick a move"
    #assert response.resp_body =~ move_button(1)
    #assert response.resp_body =~ move_button(2)
    #assert response.resp_body =~ move_button(3)
    #assert response.resp_body =~ move_button(4)
    #assert response.resp_body =~ move_button(5)
    #assert response.resp_body =~ move_button(6)
    #assert response.resp_body =~ move_button(7)
    #assert response.resp_body =~ move_button(8)
  end

end
