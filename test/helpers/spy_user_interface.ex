defmodule SpyUserInterface do

  @game_with_empty_board %Game{board: %Board{cells: [:empty, :empty,:empty,:empty,:empty,:empty,:empty,:empty,:empty]}}

  def announce_draw do
    send self, :spy_user_interface_received_announce_draw 
  end

  def announce_winner("player_one") do
    send self, :spy_user_interface_received_announce_win_with_player_one 
  end

  def announce_winner("player_two") do
    send self, :spy_user_interface_received_announce_win_with_player_two 
  end

  def announce_winner(_) do
    #This is to catch any announce_winner messages that are not being tested
    #but still being sent if the game results in a win scenario
  end

  def announce_next_move(%Game{}) do
    send self, :spy_user_interface_received_announce_next_move_with_game
  end

  def ask_next_move(input_device, board_size, valid_input) do
    send self, :spy_user_interface_received_ask_next_move
    send self, input_device: input_device
    send self, input_size: board_size
    send self, input_valid_moves: valid_input
  end

end
