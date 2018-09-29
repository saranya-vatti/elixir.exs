defmodule ElhexDelivery.PostalCode.Store do
  use GenServer
  alias ElhexDelivery.PostalCode.DataParser

  def start_link do
    # name can be now used as a reference for GenServer - so we dont have to track pid
    # drawback is that we cannot use multiple GenServers at the same time
    GenServer.start_link(__MODULE__, %{}, name: :postal_code_store)
  end

  #init has default timeout
  def init(_) do
    {:ok, DataParser.parse_data}
  end

  def get_geolocation(postal_code) do
    GenServer.call(:postal_code_store, {:get_geolocation, postal_code})
  end

  #Callbacks

  def handle_call({:get_geolocation, postal_code}, _from, geolocation_data) do
    geolocation = Map.get(geolocation_data, postal_code)
    {:reply, geolocation, geolocation_data}
  end
end
