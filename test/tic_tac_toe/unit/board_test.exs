defmodule BoardTest do
  use ExUnit.Case
  import TestHelpers

  describe "adding a move to the board" do

    test "updates the board with the given move(example 1)" do
      empty_board = create_board([x: [], o: []])
      expected_board = create_board([x: [1], o: []])
      assert Board.add_move(empty_board, {0, :x}) ===  expected_board
    end

    test "updates the board with the given move(example 2)" do
      empty_board = create_board([x: [], o: []])
      expected_board = create_board([x: [3], o: []])
      assert Board.add_move(empty_board, {2, :x}) === expected_board
    end

  end


  describe "creating a custom-sized board" do

    test "generates a 3-wide board" do
      assert Board.create_board(3) === create_board([size: 3, x: [], o: []])
    end
    
    test "generates a 4-wide board" do
      assert Board.create_board(4) === create_board([size: 4, x: [], o: []])
    end

  end


  describe "board size" do
    
    test "defaults to size three" do
      three_board = %Board{}

      assert Board.width(three_board) === 3
    end

    test "knows its size" do
      two_board = %Board{cells: [:empty,:empty,:empty,:empty]}

      assert Board.width(two_board) === 2
    end

  end


  describe "available moves" do

    test "all moves are available for an empty board" do
      board = create_board([x: [], o: []])

      assert Board.available_moves(board) === [0,1,2,3,4,5,6,7,8]
    end

    test "some moves are available for a partial board" do
      board = create_board([x: [1], o: []])

      assert Board.available_moves(board) === [1,2,3,4,5,6,7,8]
    end

    test "no moves are available for a full board" do
      board = create_board([x: [1,2,3,4,5], o: [6,7,8,9]])

      assert Board.available_moves(board) === []
    end

  end

  
  describe "checking the board status" do

    test "knows when it is empty" do
      empty_board = create_board([x: [], o: []])
      assert Board.empty?(empty_board) === true
    end

    test "knows when it is not empty" do
      non_empty_board = create_board([x: [1], o: []])
      assert Board.empty?(non_empty_board) === false
    end

    test "a board is incomplete when all cells are empty" do
      incomplete_board = %Board{}
      assert Board.status(incomplete_board) === :incomplete
    end

    test "a board with no winner nor draw is incomplete" do
      incomplete_board = create_board([x: [1,5], o: [3]])
      assert Board.status(incomplete_board) === :incomplete
    end

    test "a board with a winner is recognised (crosses wins row example)" do
      board_with_winner = create_board([x: [1,2,3], o: [4,5]])
      assert Board.status(board_with_winner) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins column example)" do
      board_with_winner = create_board([x: [1,4,7], o: [3,5]])
      assert Board.status(board_with_winner) === {:win, :x}
    end

    test "a board with a winner is recognised (crosses wins diagonal example)" do
      board_with_winner = create_board([x: [1,5,9], o: [3,4]])      
      assert Board.status(board_with_winner) === {:win, :x}
    end

    test "a board with a winner is recognised (noughts wins)" do
      board_with_winner = create_board([x: [4,5], o: [1,2,3]])      
      assert Board.status(board_with_winner) === {:win, :o}
    end

    test "a draw board is recognised" do
      draw_board = create_board([x: [2,5,6,7,9], o: [1,3,4,8]])
      assert Board.status(draw_board) === :draw
    end

  end
end
