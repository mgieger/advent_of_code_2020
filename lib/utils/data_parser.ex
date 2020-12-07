defmodule Utils.DataParser do
  def parse_input(data, func) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&func.(&1))
  end

  @doc """
  Keeps every nth row of a list.

  The index is used to determine which rows to keep. When its value is 0, the row is kept.
  Otherwise the row is discarded.

  The index defaults to 0, which ensures the first element and every nth element in the input list are kept.
  Increasing the intial index value will push out which row is the first to be kept.
  """
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
