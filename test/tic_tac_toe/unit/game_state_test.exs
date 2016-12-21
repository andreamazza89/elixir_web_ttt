defmodule GameStateTest do
  use ExUnit.Case
  import TestHelpers

  @first_cell 0
  @second_cell 1

  test "provides an id for the game state" do
    game = "I am a game"
    initial_state_id = GameState.start_game(game)
    assert is_pid(initial_state_id)
  end

  test "initialises the state to the game given" do
    game = "I am a game"
    initial_state_id = GameState.start_game(game)
    initial_game_state = GameState.get_state(initial_state_id)
    
    assert initial_game_state === "I am a game"
  end

  test "updates a game with the given move, first cell" do
    player_one = %Player.Human{mark: :x}
    player_two = %Player.Human{mark: :o}
    game = %Game{players: {player_one, player_two}}
    initial_state_id = GameState.start_game(game)

    GameState.add_move(initial_state_id, @first_cell)
    updated_game = GameState.get_state(initial_state_id) 

    assert get_cell_at(@first_cell, updated_game) === :x
  end

  test "updates a game with the given move, second cell" do
    player_one = %Player.Human{mark: :o}
    player_two = %Player.Human{mark: :x}
    game = %Game{players: {player_one, player_two}}
    initial_state_id = GameState.start_game(game)

    GameState.add_move(initial_state_id, @second_cell)
    updated_game = GameState.get_state(initial_state_id) 

    assert get_cell_at(@second_cell, updated_game) === :o
  end

end
