defmodule Day8 do

  def line_to_integers_list(line), do: String.split(line, "", trim: true) |> Enum.map(&String.to_integer/1)

  def str_to_forest(str) do
    String.split(str, "\n", trim: true) |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line_to_integers_list(line) |> Enum.with_index()
      |> Enum.map(fn {height, x} -> {{x, y}, height} end)
    end)
    |> Enum.into(%{}) # a Map with keys {x, y} and values height
  end

  def rotate(hashmap, idx) do
    hashmap |> Enum.map(fn {{x, y}, value} -> {{idx-y, x}, value} end) |> Enum.into(%{})
  end

  def cast_rays(forest, idx) do
    0..idx |> Enum.flat_map(fn y ->
      0..idx |> Enum.map_reduce(-1, fn x, max_height ->
        { {{x, y}, forest[{x, y}] > max_height}, max(forest[{x, y}], max_height)}
      end) |> elem(0)
    end)
    |> Enum.into(%{})
  end

  def merge(hashmap1, hashmap2), do:
    hashmap1 |> Enum.map(fn {key, value} -> {key, value || hashmap2[key]} end) |> Enum.into(%{})

  def main() do

    # read input, generate forest, compute square size and cast rays the first time
    forest = File.read!("input") |> str_to_forest()
    idx = (Enum.count(forest) |> :math.sqrt() |> trunc()) - 1
    result = cast_rays(forest, idx)

    # rotate forest, cast rays, merge results, do that 3 times
    {_, result } = 1..3 |> Enum.reduce({forest, result}, fn _, {forest, result} ->
      forest = rotate(forest, idx)
      {forest, cast_rays(forest, idx) |> merge(rotate(result, idx))}
    end)

    # count visible trees
    result |> Map.values() |> Enum.filter((& &1)) |> Enum.count() |> IO.inspect(label: :part_1)

  end

end

Day8.main()
