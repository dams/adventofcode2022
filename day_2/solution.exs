File.stream!("input")
|> Enum.map(& String.to_charlist(&1) |> List.to_tuple() )
|> Enum.reduce({0, 0}, fn {i, _, j, _}, {acc_part1, acc_part2} ->
  { acc_part1 + j - 87 +
    case Integer.mod(j - i - (?X-?A), 3) do
      2 -> 0       # loose
      x -> (x+1)*3 # win or draw
    end,
    acc_part2 + case j do
      ?X -> Integer.mod(i - ?A - 1, 3) + 1 + 0 # loose
      ?Y -> Integer.mod(i - ?A + 0, 3) + 1 + 3 # draw
      ?Z -> Integer.mod(i - ?A + 1, 3) + 1 + 6 # win
    end
  }
end)
|> IO.inspect()
