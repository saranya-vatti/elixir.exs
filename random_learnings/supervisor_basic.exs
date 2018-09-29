# https://youtu.be/Gdf8JXeaPjw?t=264

defmodule BasicSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(BasicOne, []),
      worker(BasicTwo, []),
      worker(BasicThree, []),
      worker(BasicFour, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end

defmodule BasicOne do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link do
    IO.puts "BasicOne is starting"
    GenServer.start_link(__MODULE__, [])
  end
end

defmodule BasicTwo do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link do
    IO.puts "BasicTwo is starting"
    GenServer.start_link(__MODULE__, [])
  end
end

defmodule BasicThree do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link do
    IO.puts "BasicThree is starting"
    GenServer.start_link(__MODULE__, [])
  end
end

defmodule BasicFour do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link do
    IO.puts "BasicFour is starting"
    GenServer.start_link(__MODULE__, [])
  end
end

{:ok, super_pid} = BasicSupervisor.start_link
# BasicOne is starting
# BasicTwo is starting
# BasicThree is starting
# BasicFour is starting

# All child processes have started
# Supervisor will still be alive
IO.inspect Process.alive?(super_pid)
# true

# Getting all the child processes
[four, three, two, one] = Supervisor.which_children(super_pid)

#Getting the pid of the first process
{_, one_pid, _, _} = one
IO.inspect one_pid
#PID<0.130.0>

#Stopping the first process
GenServer.stop(one_pid)

#As per one_for_one, BasicOne starts with a new pid now
#BasicOne is starting
#worker's "restart" strategy is "permanent"
#means always restarts

#If it was one_for_all, all processes will start and all pids will be diff
#worker's "restart" strategy is "permanent"
#means always restarts

#If it was rest_for_one, and we kill BasicTwo; BasicTwo and BasicThree and BasicFour will be restarted
#worker's "restart" strategy is "permanent"
#means always restarts

#If it was simple_one_for_one
#worker's "restart" strategy is "transient"
#means only restarts when crashed

#if worker was "temporary" - never gets restarted


#Since the BasicOne restarted with new pid, this returns false
IO.inspect Process.alive?(one_pid)
#false
[four, three, two, one] = Supervisor.which_children(super_pid)
