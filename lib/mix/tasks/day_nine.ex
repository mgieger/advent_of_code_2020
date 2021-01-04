defmodule Mix.Tasks.DayNine do
  use Mix.Task

  @sequence_length 5

  def run(_args) do
    "data_files/test/day_nine.txt"
    |> File.stream!()
    |> Stream.map(&parse(&1))
    |> Stream.chunk_every(@sequence_length, 1, :discard)
    |> Enum.reduce_while(0, fn sequence, acc ->
      IO.inspect(sequence)
      {:cont, acc}
    end)
    |> IO.inspect()
  end

  def parse(data) do
    data
    |> String.trim()
    |> String.to_integer()
  end
end
