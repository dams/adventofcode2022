File.stream!("input")
|> Enum.reduce({0,0}, fn line, {acc_part1, acc_part2} ->
    [s1, e1, s2, e2] = line
      |> String.split(~r/\D/, trim: true)
      |> Enum.map(&String.to_integer/1)
    {m1, m2} = {MapSet.new(s1..e1), MapSet.new(s2..e2)}
    {
      acc_part1 + (if MapSet.subset?(m1,m2) || MapSet.subset?(m2,m1), do: 1, else: 0),
      acc_part2 + (if MapSet.disjoint?(m1,m2), do: 0, else: 1),
    }
end)
|> IO.inspect()
