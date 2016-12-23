defmodule TicTacToe.Web.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(:http, TicTacToe.Web.Router, [],
        [port: Application.get_env(:elixir_web_ttt, :port)])
    ]

    opts = [strategy: :one_for_one, name: ElixirWebTicTacToe.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
