defmodule Day6 do

  # patternmatching fun!
  # l = the list of chars, p = position where we are in the list
  # s = the size of consecutive non-repetitive chars we're looking for
  def find_marker(l, p, s   ), do: find_marker(l, p, s, length(Enum.uniq(Enum.take(l,s))))
  def find_marker(_, p, s, s), do: p+s
  def find_marker(l, p, s, _), do: find_marker(tl(l), p+1, s)

end

list = File.read!("input") |> String.to_charlist()
Day6.find_marker(list, 0, 4)  |> IO.inspect() # part 1
Day6.find_marker(list, 0, 14) |> IO.inspect() # part 2
