defmodule Mix.Tasks.DayFour do
  use Mix.Task

  @shortdoc "Counts the number of valid passports"

  # @required_keys ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
  # @optional_keys ["cid"]

  def run(_args) do
    File.read!("data_files/day_four.txt")
    |> separate_passports()
    |> convert_passports_to_maps()
    |> count_valid_passports()
    |> IO.inspect()
  end

  defp separate_passports(data) do
    data
    |> String.split("\n\n", trim: true)
    |> Enum.map(&String.replace(&1, "\n", " "))
  end

  defp convert_passports_to_maps(data) do
    data
    |> Enum.map(&create_map/1)
  end

  defp create_map(passport_info) do
    passport_info
    |> String.split(" ")
    |> Enum.reduce(%{}, fn kv, acc ->
        [k, v] = String.split(kv, ":")
        Map.put(acc, k, v)
      end)
  end

  defp count_valid_passports(passports) do
    passports
    |> Enum.reduce(0, &validate_passport/2)
  end

  defp validate_passport(
    %{
      "byr" => _byr,
      "ecl" => _ecl,
      "eyr" => _eyr,
      "hcl" => _hcl,
      "hgt" => _hgt,
      "iyr" => _iyr,
      "pid" => _pid
    },
    acc) do
      acc + 1
  end

  defp validate_passport(_invalid_passport, acc) do
    acc
  end
end
