defmodule Utils.DataParser do
  def parse_input(data, func) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&func.(&1))
  end
end
