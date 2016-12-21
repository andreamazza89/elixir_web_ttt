defmodule StubPlayerReturnsCellZero do
  defstruct mark: :x 

  defimpl Player, for: StubPlayerReturnsCellZero do
    def get_next_move(_player, _game) do
      0
    end
  end

end
