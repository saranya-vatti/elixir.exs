# https://hashnuke.com/2016/02/07/cast-call-and-info-elixir.html
defmodule HelloServer do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def handle_call(msg, _from, state) do
    :timer.sleep 2000
    #waits 2 secs and prints as call is sync
    {:reply, "Received in call: #{msg}", state}
  end

  def handle_cast(msg, state) do
    :timer.sleep 2000
    #not printed as cast is async
    IO.puts "Received in cast: #{msg}"
    {:noreply, state}
  end

  def handle_info(msg, state) do
    IO.puts "Received in info: #{msg}"
    {:noreply, state}
  end
end

{:ok, pid} = GenServer.start HelloServer, []
IO.inspect pid
IO.inspect GenServer.call pid, "hello"
IO.inspect GenServer.cast pid, "hello"
IO.inspect send pid, "hello"
