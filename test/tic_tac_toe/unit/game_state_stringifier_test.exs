defmodule GameStateStringifierTest do
  use ExUnit.Case
  import TestHelpers
  alias TicTacToe.Web.GameStateStringifier

  test "converts a game state into a string" do
    game = %Game{}
    stringified_game = GameStateStringifier.stringify(game)

    assert is_binary(stringified_game)
  end

  test "parses a game state from a stringified version (example one)" do
    game = %Game{}
    stringified_game = GameStateStringifier.stringify(game)

    assert GameStateStringifier.parse(stringified_game) === game
  end

  test "parses a game state from a stringified version (example two)" do
    board = create_board([x: [1], o: []])
    game = %Game{board: board}
    stringified_game = GameStateStringifier.stringify(game)

    assert GameStateStringifier.parse(stringified_game) === game
  end

end
