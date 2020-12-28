defmodule Mix.Tasks.DaySeven do
  use Mix.Task

  @shortdoc "Creates graph of bags and counts them."

  @bag_of_interest "shiny gold"

  def run(["--part-one"]) do
    "data_files/day_seven.txt"
    |> File.read!()
    |> process()
    |> generate_graph()
    |> count_bags(@bag_of_interest)
  end

  def run(_args) do
    IO.inspect("Day One: #{run(["--part-one"])}")
  end

  def process(data) do
    data
    |> String.split("\n", trim: true)
    |> Enum.map(&parse_line(&1))
  end

  def parse_line(line) do
    line = Regex.named_captures(~r/(?<container>.*) bags contain (?<contained_bags>.+)/, line, trim: true)

    connected_to =
      Regex.split(~r/bag?s?,?./, line["contained_bags"], trim: true)
      |> Enum.map(fn bag ->
        bag_info =
          Regex.named_captures(~r/(?<num>\d+|no) (?<bag_type>.+)\s/, bag, trim: true)

        bag_num =
          case bag_info["num"] do
            "no" -> 0
            _num -> String.to_integer(bag_info["num"])
          end

        {bag_info["bag_type"], bag_num}
      end)

    %{
      line["container"] => connected_to
    }
  end

  def generate_graph(data) do
    graph = :digraph.new()

    Enum.map(data, &populate_graph(graph, &1))

    graph
  end

  def populate_graph(graph, vertex_map) do
    vertex = Map.keys(vertex_map) |> List.first()

    vertex_map
    |> Map.values()
    |> List.first()
    |> Enum.each(fn {desc_vertex, number} ->
      vert = :digraph.add_vertex(graph, vertex, vertex)
      desc = :digraph.add_vertex(graph, desc_vertex, desc_vertex)
      :digraph.add_edge(graph, vert, desc, number)
    end)
  end

  def count_bags(graph, bag_type) do
    :digraph_utils.reaching([bag_type], graph)
    |> Enum.count()
    |> Kernel.-(1)
  end
end
