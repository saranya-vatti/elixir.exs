#Single process, async calls
# times out as 5000 seconds exceeds for the calls
defmodule Stack do
  use GenServer, restart: :transient, shutdown: 10_000

  @doc """
  Initiate with the given value .
  """
  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], [])
  end

  def check(server_pid, [st, en]) do
    GenServer.cast(server_pid, {:check, [st, en]})
  end

  def pop(server_pid) do
    GenServer.call(server_pid, {:pop})
  end

  def init(input) do
    {:ok, input} # ----------- state is stored as list of inputs
  end

  def handle_cast({:check, [st, en]}, list) do # ----> asynchronous request
    if (sum_of_consecutive_squares(st, en) |> isPerfectSquare?) do
      {:noreply, list ++ [st]}
    else
      {:noreply, list}
    end
  end

  def sum_of_consecutive_squares(st, en) do
    if st == en do
      st * st
    else
      result = (st * st) + sum_of_consecutive_squares(st + 1, en)
      result
    end
  end

  def isPerfectSquare?(n) do
    :math.sqrt(n) |> :erlang.trunc |> :math.pow(2) == n
  end

  def handle_call({:pop}, _from, list) do
    {:reply, list, []}
  end
end

defmodule Main do
  def main do
    {:ok,pid} = Stack.start_link(1)
    Stack.check(pid,[1, 24])
    Stack.check(pid,[2, 24])
    Stack.check(pid,[34648837, 24])
    IO.inspect Stack.pop(pid)
  end
end

Main.main
