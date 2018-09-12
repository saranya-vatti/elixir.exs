# Supervisor spawns multiple GenServers, work is done in init of GenServer [not working]
defmodule MyFancyProcess do
  use GenServer

  def start_link(input) do
    GenServer.start_link(__MODULE__, input)
  end

  def isSolution([st, en]) do
    if GenServer.call(__MODULE__, {:isSolution, [st, en]}) do
      IO.puts st
    end
  end

  ## GenServer callbacks

  def init([st, en]) do
    IO.puts "Start child with pid #{inspect self()} params #{st}"
    if sum_of_consecutive_squares(st, en) |> isPerfectSquare? do
      IO.puts st
    end
    {:ok, [st, en]} #state
  end

  def handle_call({:isSolution, [st, en]}, _from, state) do
    {:reply, sum_of_consecutive_squares(st, en) |> isPerfectSquare?, state}
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
end

defmodule MyFancySupervisor do
  use Supervisor

  def start_link(arg) do
    Supervisor.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    children = [
      worker(MyFancyProcess, [[3, 4]], [id: 3, restart: :permanent]),
      worker(MyFancyProcess, [[1, 24]], [id: 1, restart: :permanent]),
      worker(MyFancyProcess, [[34648837, 34648837+24]], [id: 34648837, restart: :permanent])
    ]

    #  isolated process that shouldn’t effect any other children that the supervisor is supervising.
    opts = [strategy: :one_for_one]

    Supervisor.init(children, opts)
    #supervise(children, strategy: :one_for_one)
  end
end

{:ok, pid} = MyFancySupervisor.start_link(1)
Supervisor.count_children(pid)
Supervisor.which_children(pid)
