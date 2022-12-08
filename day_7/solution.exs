defmodule Day7 do

  def parse(["$ cd /" |rest]), do: parse(rest, %{},_size = 0)
  def parse([], tree, size), do: {tree, size, []}
  def parse(["$ cd .."|rest], tree, size), do: {tree, size, rest}
  def parse(["$ cd " <> dirname| rest], tree, size) do
    {subtree, subsize} = Map.get(tree, dirname, {%{}, 0})
    {new_subtree, new_subsize, new_rest} = parse(rest, subtree, subsize)
    new_tree = Map.put(tree, dirname, {new_subtree, new_subsize})
    new_size = size + new_subsize
    parse(new_rest, new_tree, new_size )
  end
  def parse([str | rest], tree, size) do
    [number_str] = ~r/(\d+)/ |> Regex.run(str, capture: :all_but_first)
    parse(rest, tree, size + String.to_integer(number_str))
  end


  # walk the tree and get the needed dirs
  def find_dirs(tree), do: find_dirs(tree, [])
  def find_dirs(tree, res) when tree == %{}, do: res
  def find_dirs(tree, res) do
    {_, res} = Map.keys(tree)
            |> Enum.reduce({tree, res}, fn key, {tree, res} ->
               {children, size} = Map.fetch!(tree, key)
               {tree, find_dirs(children, [size|res])}
            end)
    res
  end
end

lines = File.read!("input")
     |> String.split("\n")
     |> Enum.reject(&(&1 == "$ ls" || match?("dir " <> _, &1)))

{tree, total_size, []} = Day7.parse(lines)

dirs = tree |> Day7.find_dirs()
dirs |> Enum.filter(& &1 <= 100000) |> Enum.sum() |> IO.inspect(label: :part_1)

to_free = 30_000_000 - (70_000_000-total_size)
dirs |> Enum.filter(& &1 > to_free) |> Enum.min() |> IO.inspect(label: :part_2)
