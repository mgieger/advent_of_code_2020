defmodule Mix.Tasks.DayNine do
  use Mix.Task

  @sequence_length 25
  @target_value 138879426
  # @target_value 127

  def run(["--part-one"]) do
    data = process_file("data_files/day_nine.txt")

    invalid_value =
      Enum.chunk_every(data, @sequence_length, 1, :discard)
      |> Enum.zip(Enum.drop(data, @sequence_length))
      |> Enum.reduce_while(0, &sum_of_two?(&1, &2))

    IO.inspect("Part One: #{invalid_value}")
  end

  def run(["--part-two"]) do
    data =
      process_file("data_files/day_nine.txt")
      |> Enum.with_index()

    solution =
      Enum.reduce_while(data, [], fn elem, _ ->
       find_sequence(data, elem)
      end)
      |> encryption_weakness()

    IO.inspect("Part Two: #{solution}")
  end

  def run(_args) do
    run(["--part-one"])
    run(["--part-two"])
  end

  def process_file(file) do
    file
    |> File.stream!()
    |> Enum.map(&parse(&1))
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

   def find_sequence(data, {elem, index} = start) do
    find_sequence(start, Enum.drop(data, index + 1), [elem])
  end

  # base case
  def find_sequence(_start, [], _) do
    {:cont, []}
  end

  def find_sequence(start, tail, acc_list) do
    {tail_first, _} = List.first(tail)
    sum = tail_first + Enum.sum(acc_list)

    cond do
      sum == @target_value -> {:halt, [tail_first | acc_list]}
      sum > @target_value -> {:cont, []}
      sum < @target_value ->
        find_sequence(start, Enum.drop(tail, 1), [tail_first | acc_list])
    end
  end

  def encryption_weakness(seq) do
    Enum.min(seq) + Enum.max(seq)
  end
end
