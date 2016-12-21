defmodule GameState do

  def start_game(game) do
    {:ok, pid} = Agent.start_link(fn() -> game end)
    pid
  end

  def get_state(state_id) do
    Agent.get(state_id, &(&1))
  end

  def add_move(state_id, move) do
    Agent.get_and_update(state_id, fn(game) -> 
      new_state = Game.mark_cell_for_current_player(game, move)
      {new_state, new_state}
    end)
  end

end
