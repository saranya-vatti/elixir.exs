defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    list1 = [1, 2, 3]
    list2 = [4, 5, 6]

    list3 = list1 ++ list2

    list4 = list3 -- list1

    IO.puts 6 in list4

    [head | tail] = list3;
    IO.puts "head : #{head}"
    IO.write "tail : "
    IO.inspect tail

    IO.inspect [97,98] #prints 'ab'
    IO.inspect [97,98], char_lists: :as_lists

    Enum.each tail, fn item ->
      IO.puts item
    end

    words = ["random", "words", "in", "a", "list"]

    Enum.each words, fn word ->
      IO.puts word
    end

    IO.write "after deleting 'random' : "
    display_list(List.delete(words, "random"))

    IO.write "after deleting word at 1st index : "
    display_list(List.delete_at(words, 1))

    IO.write "after inserting 'added' word at 4th index : "
    display_list(List.insert_at(words, 5, "added"))

    IO.puts "First word in the list : #{List.first(words)}"
    IO.puts "Last word in the list : #{List.last(words)}"
  end

  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil
end
