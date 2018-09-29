# https://www.youtube.com/watch?v=Gdf8JXeaPjw

defmodule BasicSupervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      worker(Basic, [])
    ]
    supervise(children, strategy: :one_for_one)
  end
end

defmodule Basic do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end
end

{:ok, pid} = BasicSuervisor.start_link
