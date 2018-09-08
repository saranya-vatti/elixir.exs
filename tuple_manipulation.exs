defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    my_tuple = {175, 2.3, :name}
    IO.puts "is my_tuple a tuple : #{is_tuple(my_tuple)}"
    #once a var gets a value, its permanent. so if you want to mutate it, store in new var
    my_tuple2 = Tuple.append(my_tuple, 35)
    IO.puts "3rd element in my_tuple : #{elem(my_tuple2, 3)}"
    IO.puts "size of my_tuple : #{tuple_size(my_tuple2)}"
    my_tuple3 = Tuple.delete_at(my_tuple2, 0)
    my_tuple4 = Tuple.insert_at(my_tuple3, 0, 2342)
    IO.inspect(my_tuple4)
    many_zeroes = Tuple.duplicate(0, 5)
    IO.inspect(many_zeroes)
    {key1, key2, key3} = {"val1", "val2", "val3"}
    IO.puts "key1 : #{key1}"
    IO.puts "key2 : #{key2}"
    IO.puts "key3 : #{key3}"
  end
end
