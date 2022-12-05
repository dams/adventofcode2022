defmodule Day5 do

  def run(callback) do
    # split the input in the lines for the initial state, and the moves
    [state_str, moves_str] = File.read!("input") |> String.split("\n\n", trim: true)

    # split the lines for the initial state stacks, drop the last one
    state_lines = state_str |> String.split("\n") |> Enum.drop(-1)

    # compute how many stacks we have (divide length of one line by 4)
    stacks_count = (String.length(hd(state_lines)) + 1) / 4 |> trunc()

    # reduce the states lines in a Map, key = stack id, value = list of letters, top at the start
    stacks = Enum.reduce(state_lines, %{}, fn line, acc ->
      # go over all the positions where we might find a letter in the line string
      Enum.reduce((0..stacks_count-1), acc, fn key, acc ->
        pos = key*4+1 # compute letter position from the key (stack index)
        case String.at(line, pos) do
          " "  -> acc # space, no letter, don't add anything to the Map
          char -> acc |> Map.update(key, [char], fn stack -> stack ++ [ char ] end) # found a letter, prepend it in the stack
        end
      end)
    end)
    # now, go over the moves lines
    stacks = moves_str |> String.split("\n") |> Enum.reduce(stacks, fn line, acc ->
      # parse the line string, get how much should be moved from where to where
      [count, from, to] = ~r/move (\d+) from (\d+) to (\d+)/
                          |> Regex.run(line, capture: :all_but_first)
                          |> Enum.map(&String.to_integer/1)
      # take from one stack to the other, reversing on the go if needed
      {to_move, acc} = acc |> Map.get_and_update!(from-1, & Enum.split(&1, count) )
      acc |> Map.update!(to-1, & callback.(to_move) ++ &1)
    end)
    stacks |> Map.values() |> Enum.map_join(&hd/1) |> IO.inspect()
  end
end

Day5.run(&Enum.reverse/1)
Day5.run(& &1)
