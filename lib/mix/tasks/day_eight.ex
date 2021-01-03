defmodule Mix.Tasks.DayEight do
  use Mix.Task

  def run(["--part-one"]) do
    commands =
      "data_files/day_eight.txt"
      |> File.read!()
      |> process_file()

    {:cont, [acc]} = execute_command(commands, List.first(commands), 0, 0, [], Enum.count(commands))

    IO.inspect("Part One: #{acc}")
  end

  def run(["--part-two"]) do
    commands =
      "data_files/day_eight.txt"
      |> File.read!()
      |> process_file()

    %{jmp: jmp_list, nop: nop_list} = find_indices(commands)

    modified_commands =
      Enum.map(jmp_list, &swap_command(commands, :jmp, &1)) ++
      Enum.map(nop_list, &swap_command(commands, :nop, &1))

    acc =
      Enum.reduce_while(modified_commands, [], &execute_command(&1, List.first(&1), 0, 0, &2, Enum.count(commands)))
      |> List.first()

    IO.inspect("Part Two: #{acc}")
  end

  def run(_args) do
    run(["--part-one"])
    run(["--part-two"])
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

  def execute_command(_commands, _command, index, cmnd_value, acc, num_commands) when index >= num_commands do
    {:halt, [cmnd_value | acc]}
  end

  def execute_command(_commands, %{visited: true}, _index, cmnd_value, acc, _num_commands) do
    {:cont, [cmnd_value | acc]}
  end

  def execute_command(commands, %{command: "nop", value: _num, visited: false}, index, cmnd_value, acc, num_commands) do
    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + 1), index + 1, cmnd_value, acc, num_commands)
  end

  def execute_command(commands, %{command: "jmp", value: num, visited: false}, index, cmnd_value, acc, num_commands) do
    offset = String.to_integer(num)

    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + offset), index  + offset, cmnd_value, acc, num_commands)
  end

  def execute_command(commands, %{command: "acc", value: num, visited: false}, index, cmnd_value, acc, num_commands) do
    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + 1), index + 1, cmnd_value + String.to_integer(num), acc, num_commands)
  end

  def find_indices(commands) do
    commands
    |> Enum.with_index()
    |> Enum.reduce(%{jmp: [], nop: []}, fn
      {%{command: "jmp"}, index}, acc -> %{acc | jmp: [index | acc[:jmp]]}
      {%{command: "nop"}, index}, acc -> %{acc | nop: [index | acc[:nop]]}
      _, acc -> acc
    end)
  end

  def swap_command(commands, :jmp, jmp_index) do
    List.update_at(commands, jmp_index, fn cmnd ->
      %{cmnd | command: "nop"}
    end)
  end

  def swap_command(commands, :nop, nop_index) do
    List.update_at(commands, nop_index, fn cmnd ->
      %{cmnd | command: "jmp"}
    end)
  end
end
