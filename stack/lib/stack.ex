defmodule Stack do
  use GenServer

  @doc """
  Initiate with the given string .
  """
  def start_link(val) do
    GenServer.start_link(__MODULE__, val, [])
  end

  def push(server_pid, val) do
    GenServer.call(server_pid, {:push, val})
  end

  def pop(server_pid) do
    GenServer.call(server_pid, {:pop})
  end

  def init(input) do
    {:ok, [input]} # ----------- state is stored as list of inputs
  end

  def handle_call({:push, val}, _from, list) do # ----> synchronous request
    {:reply, :ok, list ++ [val]}
  end

  def handle_call({:pop}, _from, [head | tail]) do
    {:reply, head, tail}
  end
end
