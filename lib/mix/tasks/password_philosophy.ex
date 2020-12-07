defmodule Mix.Tasks.PasswordPhilosophy do
  use Mix.Task

  @shortdoc "finds the number of valid passwords"

  def run(_args) do
    File.read!("data_files/password_philosophy.txt")
    |> parse_input()
    |> Stream.map(&password_valid?/1)
    |> Enum.count(fn boolean -> boolean == true end)
    |> IO.inspect()
  end

  def parse_input(password_list) do
    password_list
    |> String.split("\n", trim: true)
    |> Stream.map(&format_line/1)
  end

  def format_line(line) do
    [numbers, value_to_find, password] = String.split(line, " ")

    [min, max] =
      numbers
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    value_to_find = String.first(value_to_find)

    {min..max, value_to_find, password}
  end

  def password_valid?({valid_range, char_to_find, password}) do
    char_count = Enum.count(String.codepoints(password), fn char -> char == char_to_find end)

    char_count in valid_range
  end
end
