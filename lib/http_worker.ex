defmodule TempLog.HTTP do
  use GenServer
  
  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end
  
  def init(_args) do
    Plug.Adapters.Cowboy.http TempLog.API, [] 
  end
end