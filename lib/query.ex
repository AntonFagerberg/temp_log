defmodule TempLog.Query do
  use Ecto.Adapters.SQL
  
  def sensors do
    result = 
      Ecto.Adapters.SQL.query(Repo, 
        """
        SELECT 
        DISTINCT 
          sensor 
        FROM 
          entry;
        """, []
      )
      
      %{sensors: Enum.map(result[:rows], &(elem(&1, 0)))}
  end
  
  def current(sensor) do
    result = 
      Ecto.Adapters.SQL.query(Repo, 
        """
        SELECT 
          temperature
        FROM
          entry
        WHERE
          sensor = $1
        ORDER BY
          id DESC
        LIMIT
          1
        ;
        """, [sensor]
      )
      
      %{temp: elem(hd(result[:rows]), 0)}
  end
  
  def minute(sensor) do
    result = 
      Ecto.Adapters.SQL.query(Repo, 
        """
        SELECT 
          EXTRACT(MINUTE FROM timestamp)::INTEGER AS minute,
          AVG(temperature)::INTEGER
        FROM
          entry
        WHERE
          timestamp::DATE = current_date
        AND
          EXTRACT(HOUR FROM timestamp) = EXTRACT(HOUR FROM current_time)
        AND
          sensor = $1
        GROUP BY
          minute
        ORDER BY
          minute
        ;
        """, [sensor]
      )
      
      Enum.reduce(result[:rows], %{minute: [], temp: []}, fn({minute, temp}, dict) ->
        %{minute: dict[:minute] ++ [minute], temp: dict[:temp] ++ [temp]}
      end)
  end
  
  def month(sensor) do
    result = 
      Ecto.Adapters.SQL.query(Repo, 
        """
        SELECT 
          EXTRACT(MONTH FROM timestamp)::INTEGER AS month,
          AVG(temperature)::INTEGER
        FROM
          entry
        WHERE
          EXTRACT(YEAR FROM timestamp) = EXTRACT(YEAR FROM current_date)
        AND
          sensor = $1
        GROUP BY
          month
        ORDER BY
          month
        ;
        """, [sensor]
      )
      
      Enum.reduce(result[:rows], %{month: [], temp: []}, fn({month, temp}, dict) ->
        %{month: dict[:month] ++ [month], temp: dict[:temp] ++ [temp]}
      end)
  end
  
  def week(sensor) do
    result = 
      Ecto.Adapters.SQL.query(Repo, 
        """
        SELECT 
          EXTRACT(WEEK FROM timestamp)::INTEGER AS week,
          AVG(temperature)::INTEGER
        FROM
          entry
        WHERE
          EXTRACT(YEAR FROM timestamp) = EXTRACT(YEAR FROM current_date)
        AND
          sensor = $1
        GROUP BY
          week
        ORDER BY
          week
        ;
        """, [sensor]
      )
      
      Enum.reduce(result[:rows], %{week: [], temp: []}, fn({week, temp}, dict) ->
        %{week: dict[:week] ++ [week], temp: dict[:temp] ++ [temp]}
      end)
  end
  
  def today(sensor) do
    result = 
      Ecto.Adapters.SQL.query(Repo,
        """
        SELECT 
          EXTRACT(HOUR FROM timestamp)::INTEGER AS hour,
          AVG(temperature)::INTEGER
        FROM
          entry
        WHERE
          timestamp::DATE = current_date
        AND
          EXTRACT(YEAR FROM timestamp) = EXTRACT(YEAR FROM current_date)
        AND
          sensor = $1
        GROUP BY
          hour
        ORDER BY
          hour
        ;
        """, [sensor]
      )
    
    Enum.reduce(result[:rows], %{hour: [], temp: []}, fn({hour, temp}, dict) ->
      %{hour: dict[:hour] ++ [hour], temp: dict[:temp] ++ [temp]}
    end)
  end
  
  def yesterday(sensor) do
    result = 
      Ecto.Adapters.SQL.query(Repo,
        """
        SELECT 
          EXTRACT(HOUR FROM timestamp)::INTEGER AS hour,
          AVG(temperature)::INTEGER
        FROM
          entry
        WHERE
          timestamp::DATE = current_date - 1
        AND
          EXTRACT(YEAR FROM timestamp) = EXTRACT(YEAR FROM current_date)
        AND
          sensor = $1
        GROUP BY
          hour
        ORDER BY
          hour
        ;
        """, [sensor]
      )
    
    Enum.reduce(result[:rows], %{hour: [], temp: []}, fn({hour, temp}, dict) ->
      %{hour: dict[:hour] ++ [hour], temp: dict[:temp] ++ [temp]}
    end)
  end
end