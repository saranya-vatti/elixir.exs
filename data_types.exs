defmodule M do
  def main do
    data_stuff()
  end

  def data_stuff do
    my_int = 3
    IO.puts "Integer #{is_integer(my_int)}"
    my_float = 3.14
    IO.puts "Float #{is_float(my_float)}"
    IO.puts "Atom #{is_atom(:Pittsburgh)}"
  end
end
