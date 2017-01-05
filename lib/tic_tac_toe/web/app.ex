defmodule TicTacToe.Web.App do
  use Application

  def start(_type, _args) do
    port = Application.get_env(:elixir_web_ttt, :port)
    IO.puts "Server running on port #{port}. Visit /tictactoe/options" <>
      " to start a new game"
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, TicTacToe.Web.Router, [],
        [port: port])
    ]

    opts = [strategy: :one_for_one, name: ElixirWebTicTacToe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
