defmodule WebHelpers do
  use ExUnit.Case
  use Plug.Test

  @options TicTacToe.Web.Router.init([])

  def assert_response_includes_move_buttons(response, moves) do
    Enum.each(moves, fn(move) ->
      assert response.resp_body =~ move_button(move)
    end)
  end

  def assert_response_excludes_move_buttons(response, moves) do
    Enum.each(moves, fn(move) ->
      assert not(response.resp_body =~ move_button(move))
    end)
  end

  def move_button(move) do
    "/tictactoe/moves/#{move}"
  end

  def get_req(path) do
    conn(:get, path)
  end

  def post_req(path) do
    conn(:post, path)
  end

  def add_session(conn, session) do
    init_test_session(conn, session)
  end

  def call_router(conn) do
    TicTacToe.Web.Router.call(conn, @options)
  end

end
