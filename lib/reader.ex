defmodule TempLog.Reader do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    Task.start_link(fn -> loop end)
  end

  def loop do
    base_dir = "/sys/bus/w1/devices/"

    folder =
      File.ls!(base_dir)
      |> Enum.filter(&(String.starts_with?(&1, "28-")))

    Enum.each(folder, fn(sensor) ->
      file = base_dir <> sensor <> "/w1_slave"
      data = File.read!(file)
      [_all, temp] = Regex.run(~r/t=(\d+)/, data)
      Repo.insert %TempLog.Entry{temperature: String.to_integer(temp), sensor: sensor}
    end)

    :timer.sleep(60_000) # Sleep 1 min before reading next value
    loop
  end
end
