defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    IO.puts "4 == 4.0 : #{4 == 4.0}"
    IO.puts "4 === 4.0 : #{4 === 4.0}"
    IO.puts "4 != 4.0 : #{4 != 4.0}"
    IO.puts "4 !== 4.0 : #{4 !== 4.0}"
    IO.puts "true and false : #{true and false}"
    IO.puts "false or false : #{false or false}"
    IO.puts "not true : #{not true}"

    if true do
      IO.puts "true statement"
    end

    unless false do
      IO.puts "unless false statement"
    end

    cond do
      false -> "chutiya hai kya. false case mein kabhi nahi jaati hain"
      true -> IO.puts "conditional default"
    end

    case 2 do
      1 -> IO.puts "1"
      3 -> IO.puts "3"
      _ -> IO.puts "case default"
    end

    IO.puts "Ternary : #{if true, do: "ternary true", else: "ternary false"}"
  end
end
