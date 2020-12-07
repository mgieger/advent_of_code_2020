defmodule Utils.DataParser do
  def parse_input(data, func) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&func.(&1))
  end

  def keep_every(list, nth, index \\ 0) do
    {keep_list, _, _} = Enum.reduce(list, {[], nth, index}, &extract_nth_row/2)

    keep_list
    |> Enum.reverse()
  end

  defp extract_nth_row(row, {acc_list, nth, 0}) do
    {List.insert_at(acc_list, 0, row), nth, nth - 1}
  end

  defp extract_nth_row(_row, {acc_list, nth, index}) do
    {acc_list, nth, index - 1}
  end
end
