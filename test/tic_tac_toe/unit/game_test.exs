defmodule GameTest do
  use ExUnit.Case
  import TestHelpers

  describe "default" do

    test "game defaults to human v machine players" do
      game = %Game{}
      {%Player.Human{}, %Player.Human{}}  = game.players
    end

  end


  describe "game status" do

    test "finds the winner if one exists" do
      winner = %Player.Human{mark: :x}
      loser = %Player.Human{mark: :o}
      win_board = create_board([x: [1,2,3], o: [4,5]])
      game = %Game{board: win_board, players: {loser, winner}}

      assert Game.winner(game) === winner
    end

    test "does not find the winner if there is not one" do
      player_1 = %Player.Human{mark: :x}
      player_2 = %Player.Human{mark: :o}
      win_board = create_board([x: [1,2], o: [4,5]])
      game = %Game{board: win_board, players: {player_1, player_2}}

      assert Game.winner(game) === nil
    end

    test "knows if a game is a draw" do
      draw_board = create_board([x: [1,2,6,7,9,], o: [3,4,5,8]])
      game = %Game{board: draw_board}

      assert Game.draw?(game) === true
    end

    test "knows if a game is not a draw" do
      draw_board = create_board([x: [1,6,7,9,], o: [3,4,5,8]])
      game = %Game{board: draw_board}

      assert Game.draw?(game) === false
    end

    test "reports a draw" do
      draw_board = create_board([x: [1,2,6,7,9,], o: [3,4,5,8]])
      game = %Game{board: draw_board}

      assert Game.status(game) === :draw
    end

    test "reports a win, player one wins" do
      win_board = create_board([x: [1,2,3], o: [4,5]])
      game = %Game{board: win_board, players: {"player_two_double", "player_one_double"}}

      assert Game.status(game) === {:win, "player_one_double"}
    end

    test "reports a win, player two wins" do
      win_board = create_board([x: [1,2], o: [4,5,6]])
      game = %Game{board: win_board, players: {"player_one_double", "player_two_double"}}

      assert Game.status(game) === {:win, "player_two_double"}
    end

    test "reports an incomplete game" do
      incomplete_board = create_board([x: [1,2], o: [4,5]])
      game = %Game{board: incomplete_board}

      assert Game.status(game) === :incomplete
    end

  end


  describe "adding moves to the board" do

    test "adds the player's move to the board" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      game = %Game{players: {player_one, player_two}}
      game_after_one_move = Game.mark_cell_for_current_player(game, 0)
      expected_board_after_one_move = create_board([x: [1], o: []])

      assert game_after_one_move.board === expected_board_after_one_move
    end

  end


  describe "getting input from players" do

    test "updates the game with the current player's move, example one" do
      stub_player =  %StubPlayerReturnsCellZero{mark: :x}
      double_player = "double_player"
      game = %Game{players: {stub_player, double_player}}

      updated_game = Game.make_next_move(game)

      assert get_cell_at(0, updated_game) === :x
    end

    test "updates the game with the current player's move, example two" do
      stub_player =  %StubPlayerReturnsCellZero{mark: :o}
      double_player = "double_player"
      board = create_board([x: [2], o: []])
      game = %Game{players: {stub_player, double_player}, board: board}

      updated_game = Game.make_next_move(game)

      assert get_cell_at(1, updated_game) === :x
      assert get_cell_at(0, updated_game) === :o
    end

  end


  describe "turn management" do

    test "it is player one's turn at the beginning of the game" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      current_player = %Game{players: {player_one, player_two}}
                         |> Game.get_current_player()

      assert current_player.mark === :x
    end

    test "it is player two's turn after a move is added" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      current_player = %Game{players: {player_one, player_two}}
                         |> Game.mark_cell_for_current_player(0)
                         |> Game.get_current_player()

      assert current_player.mark === :o
    end

    test "it is player one's turn after two moves are added" do
      player_one = %Player.Human{mark: :x}
      player_two = %Player.Human{mark: :o}
      current_player = %Game{players: {player_one, player_two}}
                         |> Game.mark_cell_for_current_player(0)
                         |> Game.mark_cell_for_current_player(1)
                         |> Game.get_current_player()

      assert current_player.mark === :x
    end

  end
end
