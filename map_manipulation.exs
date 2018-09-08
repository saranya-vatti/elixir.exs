defmodule M do
  def main do
    do_stuff()
  end

  def do_stuff do
    capitals = %{"Alabama" => "Montgomery",
      "Alaska" => "Juneau",
      "Arizona" => "Phoenix"}
    IO.puts "Capital of Alaska is : #{capitals["Alaska"]}"

    capitals2 = %{Alabama: "Montgomery",
      Alaska: "Juneau",
      arizona: "Phoenix"}
    IO.puts "Capital of Arizona is : #{capitals2.arizona}"

    capitals2 = Dict.put_new(capitals, "Arkansas", "Little Rock")

    IO.inspect(capitals2)
  end

  def display_list([word|words]) do
    IO.puts word
    display_list(words)
  end

  def display_list([]), do: nil
end
