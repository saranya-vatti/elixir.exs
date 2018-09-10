# https://medium.com/@tylerpachal/let-it-crash-creating-an-example-supervisor-in-elixir-using-otp-36ea4236b02b
## lib/MySupervisor.ex
defmodule MySupervisor do
  use GenServer

  ## API
  # The reason for passing in spec list and not just pid list is because
  # we need to know how to restart a process when it fails.
  def start_link(child_spec_list) do
    GenServer.start_link(__MODULE__, child_spec_list)
  end

  def list_processes(pid) do
    GenServer.call(pid, :list)
  end

  ## OTP Callbacks
  def init(child_spec_list) do
    Process.flag(:trap_exit, true)

    #  For that reason our state is a map where the keys are pids and the values are instructions for restarting that process.
    state = child_spec_list
    |> Enum.map(&start_child/1) # in reality we would want to check that the pid returned from apply in start_child/1 is actually a process ID by calling is_pid/1 function.
    |> Enum.into(%{})
    {:ok, state}
  end

  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  ## OTP Callbacks
  def handle_info({:EXIT, dead_pid, _reason}, state) do

    # Start new process based on dead_pid spec
    {new_pid, child_spec} = state
    |> Map.get(dead_pid)
    |> start_child()

    # Remove the dead_pid and insert the new_pid with its spec
    new_state = state
    |> Map.delete(dead_pid)
    |> Map.put(new_pid, child_spec)

    {:noreply, new_state}
  end

  ## Private Helper Functions
  defp start_child({module, function, args} = spec) do
    {:ok, pid} = apply(module, function, args)
    Process.link(pid)
    {pid, spec}
  end
end
