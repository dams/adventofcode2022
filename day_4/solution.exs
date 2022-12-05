File.stream!("input")
|> Enum.reduce({0,0}, fn line, {acc_part1, acc_part2} ->
    [s1, e1, s2, e2] = line
    |> String.split(~r/\D/, trim: true)
    |> Enum.map(&String.to_integer/1)
    {
      acc_part1 + cond do
         s1 <= s2 && e1 >= e2 -> 1
         s2 <= s1 && e2 >= e1 -> 1
         true -> 0
      end,
      acc_part2 + cond do
          Range.disjoint?(s1..e1, s2..e2) -> 0
          true -> 1
      end
    }
end)
|> IO.inspect()
