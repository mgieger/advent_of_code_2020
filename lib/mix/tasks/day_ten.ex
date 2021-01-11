defmodule Mix.Tasks.DayTen do
  use Mix.Task

  def run(["--part-one"]) do
    result =
      "data_files/day_ten.txt"
      |> process_file()
      |> difference_between_values()
      |> output_result()

    IO.inspect("Part one: #{result}")
  end

  def run(_args) do
    run(["--part-one"])
  end

  def process_file(file) do
    file
      |> File.read!()
      |> String.split("\n")
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()
  end

  def difference_between_values(adapters) do
    Enum.zip(Enum.concat([0], adapters), Enum.concat(adapters, [List.last(adapters) + 3]))
    |> Enum.map(fn {x, y} -> y - x end)
  end

  def output_result(list) do
    (Enum.filter(list, fn x -> x == 1 end) |> Enum.count()) * (Enum.filter(list, fn x -> x == 3 end) |> Enum.count())
  end
end
