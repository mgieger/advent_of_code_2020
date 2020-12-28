defmodule Mix.Tasks.DaySix do
  use Mix.Task

  def run(args) do
    {parsed_args, _, _} = OptionParser.parse(args, strict: [part_two: :boolean])

    File.read!("data_files/day_six.txt")
    |> separate_groups(parsed_args)
    |> count_yes_responses_by_group(parsed_args)
    |> Enum.sum()
    |> IO.inspect()
  end

  defp separate_groups(data, []) do
    data
    |> String.split("\n\n", trim: true)
  end

  defp separate_groups(data, [part_two: true]) do
    data
      |> String.split("\n")
      |> Enum.chunk_by(&(&1 == ""))
      |> Enum.reject(&(&1 == [""]))
  end

  defp count_yes_responses_by_group(group_list, []) do
    group_list
    |> Enum.map(&String.replace(&1, "\n", ""))
    |> Enum.map(&String.to_charlist/1)
    |> Enum.map(&Enum.uniq/1)
    |> Enum.map(&Enum.count/1)
  end

  defp count_yes_responses_by_group(data, [part_two: true]) do
    data
      |> Enum.map(&count_yes_for_whole_group/1)
  end

  defp count_yes_for_whole_group(group) do
    group
      |> Enum.map(&MapSet.new(String.graphemes(&1)))
      |> Enum.reduce(&MapSet.intersection/2)
      |> Enum.count()
  end
end
