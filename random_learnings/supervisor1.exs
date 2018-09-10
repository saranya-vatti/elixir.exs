
## Create a new Parser process
# iex(2)> {:ok, pid} = Parser.start_link()
# {:ok, #PID<0.118.0>}

## Verify the process is alive
# iex(3)> Process.alive?(pid)
# true

## Send it a valid message
# iex(4)> GenServer.call(pid, "100")
# 100

## Send it an invalid message
# iex(5)> GenServer.call(pid, "tyler")
# ** (EXIT from #PID<0.115.0>) evaluator process exited with reason: an exception was raised:
# Stacktrace here

  defmodule Parser do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  def handle_call(message, _from, state) do
    i = String.to_integer(message)
    {:reply, i, state}
  end
end
