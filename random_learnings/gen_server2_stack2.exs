defmodule Stack2 do
  use GenServer

  def main do
    # Start the server
    {:ok, pid} = GenServer.start_link(Stack, [1])

    # This is the client
    IO.inspect GenServer.call(pid, :pop)
    #=> 1

    IO.inspect GenServer.cast(pid, {:push, :world})
    #=> :ok

    IO.inspect GenServer.call(pid, :pop)
    #=> :world
  end

  def start_link([]) do
    GenServer.start_link(__MODULE__, [], [])
  end

  def push(server_pid, val) do
    GenServer.call(server_pid, {:push, val})
  end

  def pop(server_pid) do
    GenServer.call(server_pid, {:pop})
  end

  def init(input) do
    {:ok, [input]}
  end

  def handle_call({:push, val}, _from, list) do # ----> synchronous request
    {:reply, :ok, [list | val]}
  end

  def handle_call({:pop}, _from, list) do
    {:reply, :ok, Enum.drop(list, -1)}
  end
end

Stack2.main
