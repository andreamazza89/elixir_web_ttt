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

  test "creates a Human v MiniMax Machine game" do
    game = GameFactory.create_game([mode: :human_v_minimax_machine, swap_order: false])
    {%Player.Human{}, %Player.MiniMax{}} = game.players
  end

  test "assigns marks to the players in Human v MiniMax Machine" do
    game = GameFactory.create_game([mode: :human_v_minimax_machine, swap_order: false])
    {player_one, player_two} = game.players
    assert player_one.mark === :x
    assert player_two.mark === :o
  end

  test "creates a Minimax Machine v Minimax Machine game" do
    game = GameFactory.create_game([mode: :minimax_machine_v_minimax_machine, swap_order: false])
    {%Player.MiniMax{}, %Player.MiniMax{}} = game.players
  end

  test "assigns marks in a MiniMax Machine v MiniMax Machine game" do
    game = GameFactory.create_game([mode: :minimax_machine_v_minimax_machine, swap_order: false])
    {player_one, player_two} = game.players
    assert player_one.mark === :x
    assert player_two.mark === :o
  end

  test "swaps the player's order" do
    game = GameFactory.create_game([mode: :human_v_minimax_machine, swap_order: true])
    {%Player.MiniMax{}, %Player.Human{}} = game.players
  end


  test "creates a game with a custom-sized board" do
    game = GameFactory.create_game([board_size: 4, mode: :human_v_human, swap_order: true])
    assert Board.width(game.board) === 4
  end

end
