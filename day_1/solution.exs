i = File.read!("input")
  |> String.split("\n")
  |> Enum.chunk_by(& &1 == "")
  |> Enum.reject(& &1 == [""])
  |> Enum.map(fn l -> l
    |> Enum.map(&String.to_integer/1)
    |> Enum.sum()
  end)

i |> Enum.max()
  |> IO.inspect(label: :part1)

i |> Enum.sort(:desc)
  |> Enum.take(3)
  |> Enum.sum()
  |> IO.inspect(label: :part2)
