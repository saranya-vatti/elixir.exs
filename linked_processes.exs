"""
https://medium.com/learn-elixir/supervisors-and-workers-in-10-minutes-83fbad6f16d1
"""
defmodule M do
  def main() do
    Process.flag :trap_exit, true
    IO.puts "before1"
    spawn_link fn() -> :ok end
    IO.puts "after1"
    receive do
      msg -> IO.inspect msg, label: "received message"
    end

    Process.flag :trap_exit, true
    IO.puts "before2"
    spawn_link fn() -> 1 = 2 end
    Process.sleep 100
    IO.puts "after2"
    receive do
      msg -> IO.inspect msg, label: "received message"
    end
  end
end

M.main
