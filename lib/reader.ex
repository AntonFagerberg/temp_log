defmodule TempLog.Reader do
  use GenServer
  
  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end
  
  def init(_args) do
    Task.start(fn -> loop end)
  end
  
  def loop do
    # IO.puts "zup"
    :timer.sleep(500)
    loop
  end
end