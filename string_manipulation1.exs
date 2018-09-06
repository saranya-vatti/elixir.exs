defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    my_str = "My Sentence"
    IO.puts "Length: #{String.length(my_str)}"
    longer_str = my_str <> " " <> " is longer"
    IO.puts "Is 'Egg' equal to 'egg' : #{"Egg" === "egg"}"
    IO.puts "Is 'My' contained in my_str  #{String.contains?(my_str, "My")}"
    IO.puts "The first character in my_str is : #{String.first(my_str)}"
    IO.puts "The character at index 4 in my_str is : #{String.at(my_str, 4)}"
    IO.puts "Substring of my_str from 3rd index to 8th index is : #{String.slice(my_str, 3, 8)}"

    # inspect prints the internal representation
    IO.inspect String.split(longer_str, " ")
    IO.puts String.upcase(longer_str)
    IO.puts String.downcase(longer_str)
    IO.puts String.capitalize(longer_str)

    4 * 10 |> IO.puts
  end
end
