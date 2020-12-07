defmodule Mix.Tasks.PasswordPhilosophy do
  use Mix.Task

  @shortdoc "finds the number of valid passwords"

  alias Utils.Operators

  def run(args) do
    {parsed_args, _, _} = OptionParser.parse(args, strict: [part_two: :boolean])

    File.read!("data_files/password_philosophy.txt")
    |> parse_input()
    |> Stream.map(&password_valid?(&1, parsed_args))
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

    [first, second] =
      numbers
      |> String.split("-")
      |> Enum.map(&String.to_integer/1)

    value_to_find = String.first(value_to_find)

    {first, second, value_to_find, password}
  end

  def password_valid?({first, second, char_to_find, password}, []) do
    char_count = Enum.count(String.codepoints(password), fn char -> char == char_to_find end)

    char_count in first..second
  end

  def password_valid?({first, second, char_to_find, password}, [part_two: true]) do
    char_at_first_index  = char_to_find == String.at(password, first - 1)
    char_at_second_index = char_to_find == String.at(password, second - 1)

    Operators.xor(char_at_first_index, char_at_second_index)
  end
end
