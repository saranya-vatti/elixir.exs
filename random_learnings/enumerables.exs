defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do

    #checking if all values in list are even or odd
    IO.puts "Even List :  #{Enum.all?([1,2,3],
      fn(n) -> rem(n, 2) == 0 end)}"

    Enum.each([1,2,3], fn(n) -> IO.puts n end)

    dbl_list = Enum.map([1,2,3], fn(n) -> n * 2 end)
    IO.inspect dbl_list

    sum_vals = Enum.reduce([1,2,3], fn(n, sum) -> n + sum end)
    IO.puts "Sum : #{sum_vals}"

    IO.inspect Enum.uniq([1,2,2,3,3])
  end

  def sum([]), do: 0

  def sum([h|t]), do: h + sum(t)
end
