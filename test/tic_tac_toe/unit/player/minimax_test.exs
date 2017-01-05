defmodule MiniMaxTest do
  use ExUnit.Case
  import TestHelpers

  test "chooses winning move" do
    minimax_player = %Player.MiniMax{mark: :x}
    other_player = %Player.Human{mark: :o} 
    winnable_board = create_board(x: [1,3], o: [4, 5])
    game = %Game{players: {minimax_player, other_player}, board: winnable_board} 

    assert Player.get_next_move(minimax_player, game) === 1
  end

  test "chooses blocking move" do
    minimax_player = %Player.MiniMax{mark: :x}
    other_player = %Player.Human{mark: :o} 
    winnable_board = create_board(x: [1,8], o: [4, 5])
    game = %Game{players: {minimax_player, other_player}, board: winnable_board} 

    assert Player.get_next_move(minimax_player, game) === 5
  end

  test "chooses a move that prevents a fork" do
    minimax_player = %Player.MiniMax{mark: :x}
    other_player = %Player.Human{mark: :o} 
    forkable_board = create_board(x: [1], o: [5, 9])
    game = %Game{players: {minimax_player, other_player}, board: forkable_board} 

    assert Player.get_next_move(minimax_player, game) === 2
  end

  test "chooses a move that prevents another fork" do
    minimax_player = %Player.MiniMax{mark: :x}
    other_player = %Player.Human{mark: :o} 
    forkable_board = create_board(x: [6], o: [1,9])
    game = %Game{players: {minimax_player, other_player}, board: forkable_board} 

    assert Player.get_next_move(minimax_player, game) === 4
  end

  test "chooses the topleft corner at the start of the game" do
    minimax_player = %Player.MiniMax{mark: :x}
    other_player = %Player.Human{mark: :o} 
    empty_board = create_board(x: [], o: [])
    game = %Game{players: {minimax_player, other_player}, board: empty_board} 

    assert Player.get_next_move(minimax_player, game) === 0
  end

  test "chooses a move that prevents an edge trap" do
    minimax_player = %Player.MiniMax{mark: :x}
    other_player = %Player.Human{mark: :o} 
    trappable_board = create_board(x: [5], o: [2, 4])
    game = %Game{players: {minimax_player, other_player}, board: trappable_board} 

    assert Player.get_next_move(minimax_player, game) === 0
  end
end
