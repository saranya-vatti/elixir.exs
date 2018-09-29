# https://youtu.be/Gdf8JXeaPjw?t=264

defmodule BasicSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(BasicOne, [])
    ]
    supervise(children, strategy: :simple_one_for_one)
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

{:ok, super_pid} = BasicSupervisor.start_link

Supervisor.which_children(super_pid)
#[]
#unlike other strategies, the child processes wont be started when we start parent process

#manually starting child process
{:ok, one_pid} = Supervisor.start_child(super_pid, [])
#BasicOne is starting
#{:ok, #PID<0.130.0>}

#can start multiple times
#diff pid
{:ok, one_pid} = Supervisor.start_child(super_pid, [])
#BasicOne is starting
#{:ok, #PID<0.131.0>}

[basic_a, basic_b] = Supervisor.which_children(super_pid)
{_, basic_a_pid, _, _} = basic_a
#[
#  {:undefined, #PID<0.130.0>, :worker, [BasicOne]},
#  {:undefined, #PID<0.131.0>, :worker, [BasicOne]}
#]

Supervisor.terminate_child(super_pid, basic_a_pid)
IO.inspect Supervisor.which_children(super_pid)
#[{:undefined, #PID<0.125.0>, :worker, [BasicOne]}]
#only one child is remaining since we killed the other one

