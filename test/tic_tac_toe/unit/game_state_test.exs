defmodule GameStateTest do
  use ExUnit.Case
  import TestHelpers

  @first_cell 0
  @second_cell 1

  test "provides an id for the game state" do
    game = "this is a game double"
    state_id = GameState.start_game(game)

    assert is_pid(state_id)
  end

  test "initialises the state to the game given" do
    game = "This is a game double"
    state_id = GameState.start_game(game)
    initial_game_state = GameState.get_state(state_id)
    
    assert initial_game_state === "This is a game double"
  end

  test "updates a game with the given move, first cell" do
    state_id = GameState.start_game(create_game_with_human_players(:x, :o))

    GameState.add_move(state_id, @first_cell)
    updated_game = GameState.get_state(state_id) 

    assert get_cell_at(@first_cell, updated_game) === :x
  end

  test "updates a game with the given move, second cell" do
    state_id = GameState.start_game(create_game_with_human_players(:o, :x))

    GameState.add_move(state_id, @second_cell)
    updated_game = GameState.get_state(state_id) 

    assert get_cell_at(@second_cell, updated_game) === :o
  end

end
