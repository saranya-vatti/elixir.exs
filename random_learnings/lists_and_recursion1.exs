defmodule M do
  def main do
    IO.puts empty? [1, 2, 3] # Returns false
    IO.puts empty? []        # Returns true

    IO.puts first([ 1 ])            # Returns 1
    IO.puts first([ 3, 1, 2, 5, 1]) # Returns 3

    IO.puts count([])
    IO.puts count([1])
    IO.puts count([3, 1, 2, 5, 1])

    IO.inspect flatten([ [1], [ 2, [3] ] , [4]]) # Returns [1,2,3,4]
    IO.inspect flatten([ [], [ [], [3] ] , [4]]) # Returns [3,4]

    IO.puts length([1, 2, 3])
  end

  def empty?([]), do: true
  def empty?(list) when is_list(list) do
    false
  end

  def first([ head | _tail ]), do: head

  def count([]), do: 0
  def count([ head | tail ]) do
    1 + count(tail)
  end

  def flatten([]), do: []

  def flatten([ head | tail ]) do
    flatten(head) ++ flatten(tail)
  end

  def flatten(head), do: [ head ]

  def length(the_list) do
    length(the_list, 0)
  end

  def length([], cnt) do
    cnt
  end

  def length([_head|tail], cnt) do
    length(tail, cnt + 1)
  end
end
