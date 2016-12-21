defmodule TicTacToe.Router do
  use Plug.Router

  plug Plug.Logger
  plug :match
  plug :dispatch

  get ("/") do
    conn |> put_resp_content_type("text/plain") |> send_resp(200, "yo")
  end

end
