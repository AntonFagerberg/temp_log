defmodule TempLog.Reader do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    Task.start_link(fn -> loop end)
  end

  defp loop do
    base_dir = "/sys/bus/w1/devices/"

    sensors =
      File.ls!(base_dir)
      |> Enum.filter(&(String.starts_with?(&1, "28-")))

    Enum.each(sensors, fn(sensor) ->
      sensor_data = base_dir <> sensor <> "/w1_slave" |> File.read!
      [_all, temp] = Regex.run(~r/t=(\d+)/, sensor_data)
      
      Repo.insert %TempLog.Entry{
        temperature: String.to_integer(temp),
        sensor: sensor,
        timestamp: :calendar.local_time
      }
    end)

    :timer.sleep(60_000) # Sleep 1 min before reading the next value.
    loop
  end
end
