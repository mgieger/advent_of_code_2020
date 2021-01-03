defmodule Mix.Tasks.DayEight do
  use Mix.Task

  def run(["--part-one"]) do
    commands =
      "data_files/day_eight.txt"
      |> File.read!()
      |> process_file()

    {:cont, acc} = execute_command(commands, List.first(commands), 0, 0, Enum.count(commands))

    IO.inspect(acc)
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

    Enum.reduce_while(modified_commands, 0, &execute_command(&1, List.first(&1), 0, &2, Enum.count(commands)))
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

  def execute_command(_commands, _command, index, acc, num_commands) when index >= num_commands do
    {:halt, acc}
  end

  def execute_command(_commands, %{visited: true}, _index, _acc, _num_commands) do
    {:cont, 0}
  end

  def execute_command(commands, %{command: "nop", value: _num, visited: false}, index, acc, num_commands) do
    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + 1), index + 1, acc, num_commands)
  end

  def execute_command(commands, %{command: "jmp", value: num, visited: false}, index, acc, num_commands) do
    offset = String.to_integer(num)

    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + offset), index  + offset, acc, num_commands)
  end

  def execute_command(commands, %{command: "acc", value: num, visited: false}, index, acc, num_commands) do
    List.update_at(commands, index, fn cmnd ->
      %{cmnd | visited: true}
    end)
    |> execute_command(Enum.at(commands, index + 1), index + 1, acc + String.to_integer(num), num_commands)
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
