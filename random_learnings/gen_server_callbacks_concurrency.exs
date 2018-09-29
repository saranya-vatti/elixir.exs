# https://www.youtube.com/watch?v=4yogCxBoO-A

defmodule SomeModule do
  def get_those_packages_out do
    packages = ["Book", "Bat", "Broom", "Bananas"]
    {:ok, pid} = PackageReciever.start_link
    Enum.each(packages, fn(package) ->
     IO.puts "Delivering package: #{package}"
     PackageReciever.leave_at_door(pid, package)
     PackageReciever.listen(length(packages))
    end)

    IO.puts "All done with deliverables"
    IO.puts "---------------------------"
  end
end

defmodule PackageReciever do
  use GenServer

  def init(args) do
    {:ok, args}
  end

  def start_link do
    GenServer.start_link(__MODULE__, [])
  end

  def leave_at_door(reciever_pid, package_name) do
    GenServer.cast(reciever_pid, {:async_package, package_name})
  end

  def handle_cast({:async_package, package_name}, state) do
    :timer.sleep(1000)
    IO.puts "I recieved package: #{package_name}"
    {:no_reply, state}
  end
end

SomeModule.get_those_packages_out
