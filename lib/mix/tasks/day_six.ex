defmodule Mix.Tasks.DaySix do
  use Mix.Task

  def run(_args) do
    File.read!("data_files/day_six.txt")
    |> separate_groups()
    |> count_yes_responses()
    |> IO.inspect()
  end

  def separate_groups(data) do
    data
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.replace(&1, "\n", ""))
  end

  def count_yes_responses(group_list) do
    group_list
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&Enum.count/1)
    |> Enum.sum()
  end
end
