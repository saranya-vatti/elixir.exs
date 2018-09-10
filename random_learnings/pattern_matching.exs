defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    [_, [_, width]] = [20, [40, 30]]
    IO.puts "Width : #{width}"

    #anon func
    get_sum = fn (x, y) -> x+y end

    IO.puts "4 + 5 = #{get_sum.(4, 5)}"

    get_diff = &(&1 - &2)

    IO.puts "5 - 4 = #{get_diff.(5, 4)}"

    add_sum = fn
      {x, y} -> IO.puts "#{x} + #{y} = #{x+y}"
      {x, y, z} -> IO.puts "#{x} + #{y} + #{z} = #{x+y+z}"
    end

    add_sum.({1,2})
    add_sum.({1,2,3})

    IO.puts do_it()
  end

  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil

  def do_it(x \\ 1, y \\ 1) do
    x + y
  end
end
