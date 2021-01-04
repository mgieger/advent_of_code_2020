defmodule Mix.Tasks.DayNine do
  use Mix.Task

  @sequence_length 25

  def run(_) do
    data =
      "data_files/day_nine.txt"
      |> File.stream!()
      |> Enum.map(&parse(&1))

    invalid_value =
      Enum.chunk_every(data, @sequence_length, 1, :discard)
      |> Enum.zip(Enum.drop(data, @sequence_length))
      |> Enum.reduce_while(0, &sum_of_two?(&1, &2))

    IO.inspect("Part One: #{invalid_value}")
  end

  def run(_args) do
    run(["--part-one"])
  end

  def parse(data) do
    data
    |> String.trim()
    |> String.to_integer()
  end

  def sum_of_two?({sequence, next}, _acc) do
    case find_value(sequence, sequence, next) do
      {:not_found} -> {:halt, next}
      {:found} -> {:cont, 0}
    end
  end

  def find_value([], _comparison_list, _value) do
    {:not_found}
  end

  def find_value([head | tail], comparison_list, value) do
    complementary_element = Enum.find(comparison_list, fn x -> x + head == value end)

    case complementary_element do
      nil -> find_value(tail, comparison_list, value)
      _ -> {:found}
    end
  end
end
