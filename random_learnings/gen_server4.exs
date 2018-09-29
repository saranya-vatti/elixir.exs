# https://www.youtube.com/watch?v=zC7TcrRi46Q

defmodule Typical do
  use GenServer

  @doc """
  Initiate with the given roumor .
  """
  def start_link(data) do
    GenServer.start_link(Typical, data)
  end

  def init(initial_data) do
    IO.puts "I am in the init method"
    IO.inspect initial_data
    {:ok, initial_data}
  end

  def get_our_data(pid) do
    GenServer.call(pid, {:get_data})
  end

  def handle_call({:get_data}, _from, data) do # ----> synchronous request
    {:reply, data, data}
  end
end

{:ok, pid} = Typical.start_link("Hello there")
Typical.get_our_data(pid)
