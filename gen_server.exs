defmodule M do
  def main do
    # Start the server
    {:ok, pid} = GenServer.start_link(Stack, [:hello])

    # This is the client
    GenServer.call(pid, :pop)
    #=> :hello

    GenServer.cast(pid, {:push, :world})
    #=> :ok

    GenServer.call(pid, :pop)
    #=> :world
  end

  defmodule Stack do
    use GenServer

    # Callbacks

    @impl true
    def init(stack) do
      {:ok, stack}
    end

    @impl true
    def handle_call(:pop, _from, [head | tail]) do
      {:reply, head, tail}
    end

    @impl true
    def handle_cast({:push, item}, state) do
      {:noreply, [item | state]}
    end
  end
end


