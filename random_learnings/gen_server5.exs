# https://www.youtube.com/watch?v=zC7TcrRi46Q

defmodule Basic do
  use GenServer

  @doc """
  Initiate with the given roumor .
  """
  def start_link do
    GenServer.start_link(__MODULE__, "Hello")
  end

  def init(initial_data) do
    greetings = %{:greeting => initial_data}
    {:ok, greetings}
  end

  def get_my_greeting(process_id) do
    GenServer.call(process_id, {:get_my_greeting})
  end

  def set_my_greeting(process_id, new_greeting) do
    GenServer.call(process_id, {:set_my_greeting, new_greeting})
  end

  def handle_call({:get_my_greeting}, _from, my_state) do # ----> synchronous request
    current_greeting = Map.get(my_state, :greeting)
    {:reply, current_greeting, my_state}
  end

  def handle_call({:set_my_greeting, new_greeting}, _from, my_state) do # ----> synchronous request
    new_state = Map.put(my_state, :greeting, new_greeting)
    {:reply, new_state, new_state}
  end
end

{:ok, basic_pid} = Basic.start_link
greeting = Basic.get_my_greeting(basic_pid)
IO.puts greeting
Basic.set_my_greeting(basic_pid, "Ahoy")
greeting = Basic.get_my_greeting(basic_pid)
IO.puts greeting
