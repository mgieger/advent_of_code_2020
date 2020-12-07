defmodule Utils.Operators do
  @spec xor(boolean, boolean) :: boolean
  def xor(left, right) do
    (left and (not right)) or ((not left) and right)
  end
end
