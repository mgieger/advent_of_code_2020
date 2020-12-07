defmodule Mix.Tasks.DayThree do
  use Mix.Task

  @shortdoc "Finds the number of trees the toboggan encounters"

  @part_one_toboggan_path [{1, 3}]
  @part_two_toboggan_path [{1, 1}, {1, 3}, {1, 5}, {1, 7}, {2, 1}]

  alias Utils.DataParser

  def run(args) do
    {parsed_args, _, _} = OptionParser.parse(args, strict: [part_two: :boolean])

    File.read!("data_files/day_three.txt")
    |> String.split("\n", trim: true)
    |> add_coordinate_set(parsed_args)
    |> toboggan_down_the_hill()
    |> IO.inspect()
  end

  def add_coordinate_set(data, []) do
    {data, @part_one_toboggan_path}
  end

  def add_coordinate_set(data, [part_two: true]) do
    {data, @part_two_toboggan_path}
  end

  def toboggan_down_the_hill({data, path_list}) do
    trees_encountered =
      path_list
      |> Enum.map(&toboggan_run(&1, data))
      |> Enum.reduce(1, fn({_, _, trees_encountered}, acc) -> acc * trees_encountered end)

    trees_encountered
  end

  def toboggan_run({row_shift, column_shift}, data) when row_shift > 1 do
    # shape data to remove excess rows
    data
    |> Enum.drop(1)
    |> DataParser.keep_every(2,1)
    |> Enum.reduce({0, column_shift, 0}, &determine_spot_and_increment_count/2)
  end

  def toboggan_run({_row_shift, column_shift}, data) do
    data
    |> Enum.drop(1)
    |> Enum.reduce({0, column_shift, 0}, &determine_spot_and_increment_count/2)
  end

  def determine_spot_and_increment_count(row_string, {index, index_shift, tree_count}) do
    {encountered_tree, new_index} =
      index
      |> update_index(index_shift, Enum.count(String.to_charlist(row_string)))
      |> encountered_tree?(row_string)

    case encountered_tree do
      true -> {new_index, index_shift, tree_count + 1}
      false -> {new_index, index_shift, tree_count}
    end
  end

  def update_index(index, index_shift, row_length) do
    case index + index_shift >= row_length do
      true -> rem(index + index_shift, row_length)
      false -> index + index_shift
    end
  end

  def encountered_tree?(index, row) do
    {String.at(row, index) == "#", index}
  end
end
