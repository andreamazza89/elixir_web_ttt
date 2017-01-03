defmodule UI.GameFactoryTest do
  use ExUnit.Case

  test "creates a Human v Human game" do
    game = GameFactory.create_game([mode: :human_v_human, swap_order: false])
    {%Player.Human{}, %Player.Human{}} = game.players
  end

  test "assigns marks in a Human v Human game" do
    game = GameFactory.create_game([mode: :human_v_human, swap_order: false])
    {player_one, player_two} = game.players
    assert player_one.mark === :x
    assert player_two.mark === :o
  end

  test "swaps the player's order" do
    game = GameFactory.create_game([mode: :human_v_human, swap_order: true])
    {%Player.Human{mark: :o}, %Player.Human{mark: :x}} = game.players
  end

  test "creates a game with a custom-sized board" do
    game = GameFactory.create_game([board_size: 4, mode: :human_v_human, swap_order: true])
    assert Board.width(game.board) === 4
  end

end
