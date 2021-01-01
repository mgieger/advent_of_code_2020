defmodule Mix.Tasks.DayEight do
  use Mix.Task

  def run(_args) do
    commands =
      "data_files/day_eight.txt"
      |> File.read!
      |> process_file()

    execute_command(commands, List.first(commands), 0, 0)
      |> IO.inspect()
  end

  def process_file(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&into_command_map(&1))
  end

  def into_command_map(command) do
    line = Regex.named_captures(~r/(?<command>\w+)\s(?<value>.+)/, command)

    %{command: line["command"], value: line["value"], visited: false}
  end

  def execute_command(_commands, %{visited: true}, _index, acc) do
    acc
  end

  def execute_command(commands, %{command: "nop", value: _num, visited: false}, index, acc) do
    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + 1), index + 1, acc)
  end

  def execute_command(commands, %{command: "jmp", value: num, visited: false}, index, acc) do
    offset = String.to_integer(num)

    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + offset), index  + offset, acc)
  end

  def execute_command(commands, %{command: "acc", value: num, visited: false}, index, acc) do
    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + 1), index + 1, acc + String.to_integer(num))
  end
end
