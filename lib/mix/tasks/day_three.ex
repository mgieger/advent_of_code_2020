defmodule Mix.Tasks.DayThree do
  use Mix.Task

  @shortdoc "Finds the number of trees the toboggan encounters"

  def run(_args) do
    File.read!("data_files/day_three.txt")
    |> parse_input()
    |> tobaggan_down_the_hill()
    |> IO.inspect()
  end

  def parse_input(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.drop(1)
  end

  def tobaggan_down_the_hill(data) do
    {_index, trees_encountered} =
      data
      |> Enum.reduce({0, 0}, &determine_spot_and_increment_count/2)

    trees_encountered
  end

  def determine_spot_and_increment_count(row_string, {index, tree_count}) do
    {encountered_tree, new_index} =
      index
      |> update_index(Enum.count(String.to_charlist(row_string)))
      |> encountered_tree?(row_string)

    case encountered_tree do
      true -> {new_index, tree_count + 1}
      false -> {new_index, tree_count}
    end
  end

  def update_index(index, row_length) do
    case index + 3 >= row_length do
      true -> rem(index + 3, row_length)
      false -> index + 3
    end
  end

  def encountered_tree?(index, row) do
    {String.at(row, index) == "#", index}
  end
end
