defmodule Mix.Tasks.DayFive do
  use Mix.Task

  @shortdoc "Finds the user's plane seat"

  def run(_args) do
    File.read!("data_files/day_five.txt")
    |> separate_boarding_passes()
    |> determine_seat_ids()
    |> Enum.max()
    |> IO.inspect()
  end

  defp separate_boarding_passes(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&convert_keys/1)
    |> Enum.map(&String.split_at(&1, 7))
  end

  defp convert_keys(boarding_pass) do
    boarding_pass
    |> String.replace("F", "L")
    |> String.replace("B", "U")
    |> String.replace("R", "U")
  end

  defp determine_seat_ids(data) do
    data
    |> Enum.map(&determine_seat_id/1)
  end

  defp determine_seat_id({row_key, col_key} = boarding_pass) do
    row = binary_search(String.to_charlist(row_key), 0..127)
    col = binary_search(String.to_charlist(col_key), 0..7)
    calculate_to_seat_id(row, col)
  end

  defp binary_search([last | []], range) do
    case last do
      ?U -> Enum.at(range, 1)
      ?L -> Enum.at(range, 0)
    end
  end

  defp binary_search([head | tail], range) do
    {lower, upper} = Enum.split(range, div(Enum.count(range), 2))

    case head do
      ?U -> binary_search(tail, upper)
      ?L -> binary_search(tail, lower)
    end
  end

  defp calculate_to_seat_id(row, col) do
    (row * 8) + col
  end
end
