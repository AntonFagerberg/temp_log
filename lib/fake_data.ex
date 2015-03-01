defmodule TempLog.FakeData do
  def generate do
    Task.start(fn ->
      :random.seed(:os.timestamp)
      
      Repo.insert %TempLog.Entry{
        temperature: :random.uniform(60000) - 30000,
        sensor: "test",
        timestamp: {
          {
            2015,
            :random.uniform(12),
            :random.uniform(31)
          }, {
            :random.uniform(24) - 1,
            :random.uniform(60) - 1,
            :random.uniform(60 - 1)
          }
        }
      }
    end)
    
    :timer.sleep(1)
    generate
  end
end
