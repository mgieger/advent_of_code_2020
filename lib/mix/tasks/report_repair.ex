defmodule Mix.Tasks.ReportRepair do
  use Mix.Task

  @shortdoc "finds two integers in a list which add up to 2020"

  @no_match_found "No matches for that criteria"

  def run(args) do
    {parsed_args, _, _} = OptionParser.parse(args, strict: [brute_force: :boolean, part_two: :boolean])

    open_report()
    |> convert_to_integers()
    |> process_report(parsed_args, 2020)
    |> IO.inspect()
  end

  def open_report do
    File.read!("data_files/report_repair.txt")
  end

  def convert_to_integers(report_content) do
    report_content
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  def process_report(integer_list, [], value) do
      generate_and_fill_buckets(integer_list)
      |> process_buckets(value)
  end

  # Performs at most 40000 comparisons (n^2)
  def process_report(integer_list, [brute_force: true], value) do
    case find_value(integer_list, integer_list, value) do
      {:found, x, y } -> "#{x} * #{y} = #{x * y}"
      {:ok, :not_found}  -> @no_match_found
    end
  end

  # Performs at most 8000000 comparisons (n^3)
  def process_report(integer_list, [part_two: true], value) do
    case find_value(integer_list, integer_list, integer_list, value) do
      {:found, x, y, z} -> "#{x} * #{y} * #{z} = #{x * y * z}"
      {:ok, :not_found}  -> @no_match_found
    end
  end

  def find_value([], _comparison_list, _value) do
    {:ok, :not_found}
  end

  def find_value([head | tail], comparison_list, value) do
    complementary_element = Enum.find(comparison_list, fn x -> x + head == value end)

    case complementary_element do
      nil -> find_value(tail, comparison_list, value)
      _ -> {:found, head, complementary_element}
    end
  end

  def find_value([], _list_two, _list_three, _value) do
    {:ok, :not_found}
  end

  def find_value([head | tail], list_two, list_three, value) do
    case find_value(list_two, list_three, value - head) do
      {:ok, :not_found} -> find_value(tail, list_two, list_three, value)
      {:found, x, y} -> {:found, head, x, y}
    end
  end

  def generate_and_fill_buckets(integer_list) do
    buckets = List.to_tuple(for _ <- 0..9, do: [])
    Enum.reduce(integer_list, buckets, fn x, acc ->
      i = rem(x, 10)
      put_elem(acc, i, [x | elem(acc, i)])
    end)
  end

  # With uniform distribution of values, Performs ~4020 comparisons
  def process_buckets(buckets, value) do
    buckets_to_compare = [{0, 0}, {1, 9}, {2, 8}, {3, 7}, {4, 6}, {5, 5}]

    {:found, x, y} =
    Enum.reduce(buckets_to_compare, [], fn compare_bucket_tuple, acc ->
      List.insert_at(
        acc,
        0,
        find_value(
          elem(buckets, elem(compare_bucket_tuple, 0)),
          elem(buckets, elem(compare_bucket_tuple, 1)),
          value
        )
      )
    end)
    |> Enum.find(fn result_tuple ->
      elem(result_tuple, 0) == :found
    end)

    "#{x} * #{y} = #{x * y}"
  end
end
