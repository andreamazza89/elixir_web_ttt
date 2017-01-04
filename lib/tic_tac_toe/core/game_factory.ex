defmodule GameFactory do

  @default_board_size 3

  def create_game(options, io \\ {UI.Console, :stdio})

  def create_game([board_size: board_size, mode: mode, swap_order: swap?], io) do
    board = Board.create_board(board_size)
    players = generate_players(mode, io)
    %Game{board: board, players: swap_players(players, swap?)}
  end

  def create_game([mode: mode, swap_order: swap?], io) do
    create_game([board_size: @default_board_size, mode: mode, swap_order: swap?], io)
  end

  defp generate_players(mode, io) do
    case mode do
      :human_v_human ->
        {%Player.Human{mark: :x, io: io}, %Player.Human{mark: :o, io: io}}
      :human_v_minimax_machine ->
        {%Player.Human{mark: :x, io: io}, %Player.MiniMax{mark: :o}}
      :minimax_machine_v_minimax_machine ->
        {%Player.MiniMax{mark: :x}, %Player.MiniMax{mark: :o}}
    end
  end

  defp swap_players({player_one, player_two}, swap?) when swap? do
    {player_two, player_one}
  end

  defp swap_players({player_one, player_two}, swap?) when not swap? do
    {player_one, player_two}
  end

end
