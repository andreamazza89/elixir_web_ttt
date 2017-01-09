defmodule GameStateSerialiserTest do
  use ExUnit.Case
  import TestHelpers
  alias TicTacToe.Web.GameStateSerialiser

  test "converts a game state into a serialised version" do
    game = %Game{}
    serialised_game = GameStateSerialiser.serialise(game)

    assert is_binary(serialised_game)
  end

  test "parses a game state from a serialised version (example one)" do
    game = %Game{}
    serialised_game = GameStateSerialiser.serialise(game)

    assert GameStateSerialiser.parse(serialised_game) === game
  end

  test "parses a game state from a serialised version (example two)" do
    board = create_board([x: [1], o: []])
    game = %Game{board: board}
    serialised_game = GameStateSerialiser.serialise(game)

    assert GameStateSerialiser.parse(serialised_game) === game
  end

end
