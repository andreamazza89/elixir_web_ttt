defmodule HumanPlayerTest do
  use ExUnit.Case
  import TestHelpers

  test "delegates to the user interface to ask for input example one" do  
    board = create_board(size: 3, x: [1], o: [])
    game = %Game{board: board}
    input_device = "double input device"
    player = %Player.Human{io: {SpyUserInterface, input_device}}
    Player.get_next_move(player, game)

    assert_received :spy_user_interface_received_ask_next_move
    assert_received input_device: "double input device"
    assert_received input_size: 3
    assert_received input_valid_moves: [1,2,3,4,5,6,7,8]
  end

  test "delegates to the user interface to ask for input example two" do  
    board = create_board(size: 2, x: [1], o: [])
    game = %Game{board: board}
    input_device = "double input device"
    player = %Player.Human{io: {SpyUserInterface, input_device}}
    Player.get_next_move(player, game)

    assert_received :spy_user_interface_received_ask_next_move
    assert_received input_device: "double input device"
    assert_received input_size: 2
    assert_received input_valid_moves: [1,2,3]
  end

end
