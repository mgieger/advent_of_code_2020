defmodule Mix.Tasks.DayThree do
  use Mix.Task

  @shortdoc "Finds the number of trees the toboggan encounters"

  @part_one_coordinates [{0, 0}]
  @part_two_coordinates []

  def run(args) do
    {parsed_args, _, _} = OptionParser.parse(args, strict: [part_two: :boolean])

    File.read!("data_files/day_three.txt")
    |> parse_input()
    |> add_coordinate_set(parsed_args)
    |> toboggan_down_the_hill()
    |> IO.inspect()
  end

  def parse_input(data) do
    data
    |> String.split("\n", trim: true)
  end

  def add_coordinate_set(data, []) do
    {data, @part_one_coordinates}
  end

  def add_coordinate_set(data, [part_two: true]) do
    {data, @part_two_coordinates}
  end

  def toboggan_down_the_hill({data, coordinate_set}) do
    trees_encountered =
      coordinate_set
      |> Enum.map(&toboggan_run(&1, data))
      |> Enum.reduce(1, fn({_index, trees_encountered}, acc) -> acc * trees_encountered end)

    trees_encountered
  end

  def toboggan_run({row, column}, data) do
    data
    |> Enum.drop(row + 1)
    |> Enum.reduce({column, 0}, &determine_spot_and_increment_count/2)
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
