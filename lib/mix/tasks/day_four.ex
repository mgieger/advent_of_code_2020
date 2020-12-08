defmodule Mix.Tasks.DayFour do
  use Mix.Task

  @shortdoc "Counts the number of valid passports"

  @eye_colors ~w(amb blu brn gry grn hzl oth)

  def run(args) do
    {parsed_args, _, _} = OptionParser.parse(args, strict: [part_two: :boolean])

    File.read!("data_files/day_four.txt")
    |> separate_passports()
    |> convert_passports_to_maps()
    |> count_valid_passports(parsed_args)
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

  defp count_valid_passports(passports, parsed_args) do
    {valid_passports, _} =
      passports
      |> Enum.reduce({0, parsed_args}, &validate_passport/2)

    valid_passports
  end

  defp validate_passport(
    %{
      "byr" => byr,
      "ecl" => ecl,
      "eyr" => eyr,
      "hcl" => hcl,
      "hgt" => hgt,
      "iyr" => iyr,
      "pid" => pid
    },
    {acc, [part_two: true]}
  ) do
    byr = String.to_integer(byr)
    iyr = String.to_integer(iyr)
    eyr = String.to_integer(eyr)
    valid_hgt = height_valid?(hgt, Regex.match?(~r/^(\d+)(cm|in)$/, hgt))
    valid_hcl = Regex.match?(~r/^#[a-f0-9]{6}$/, hcl)
    valid_ecl = Enum.any?(@eye_colors, fn color -> color == ecl end)
    valid_pid = Regex.match?(~r/^\d{9}$/, pid)

    with(
      true <- 1920 <= byr and byr <= 2002,
      true <- 2010 <= iyr and iyr <= 2020,
      true <- 2020 <= eyr and eyr <= 2030,
      true <- valid_hgt,
      true <- valid_hcl,
      true <- valid_ecl,
      true <- valid_pid
    ) do
      {acc + 1, [part_two: true]}
    else
      _ -> {acc, [part_two: true]}
    end
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
    {acc, []}
    ) do
      {acc + 1, []}
  end

  defp validate_passport(_invalid_passport, acc) do
    acc
  end

  defp height_valid?(hgt, true) do
    [_hgt, value, unit] = List.flatten(Regex.scan(~r/^(\d+)(cm|in)$/, hgt))
    value = String.to_integer(value)

    case unit do
      "cm" -> 150 <= value and value <= 194
      "in" -> 59 <= value and value <= 76
    end
  end

  defp height_valid?(_hgt, false) do
    false
  end
end
