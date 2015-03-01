defmodule TempLog.Query do
  use Ecto.Adapters.SQL
  
  def current do
    result = 
      Ecto.Adapters.SQL.query(Repo, 
        """
        SELECT 
          temperature
        FROM
          entry
        ORDER BY
          id DESC
        LIMIT
          1
        ;
        """, []
      )
      
      %{temp: elem(hd(result[:rows]), 0)}
  end
  
  def minute do
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
        GROUP BY
          minute
        ORDER BY
          minute
        ;
        """, []
      )
      
      Enum.reduce(result[:rows], %{minute: [], temp: []}, fn({minute, temp}, dict) ->
        %{minute: dict[:minute] ++ [minute], temp: dict[:temp] ++ [temp]}
      end)
  end
  
  def month do
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
        GROUP BY
          month
        ORDER BY
          month
        ;
        """, []
      )
      
      Enum.reduce(result[:rows], %{month: [], temp: []}, fn({month, temp}, dict) ->
        %{month: dict[:month] ++ [month], temp: dict[:temp] ++ [temp]}
      end)
  end
  
  def week do
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
        GROUP BY
          week
        ORDER BY
          week
        ;
        """, []
      )
      
      Enum.reduce(result[:rows], %{week: [], temp: []}, fn({week, temp}, dict) ->
        %{week: dict[:week] ++ [week], temp: dict[:temp] ++ [temp]}
      end)
  end
  
  def today do
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
        GROUP BY
          hour
        ORDER BY
          hour
        ;
        """, []
      )
    
    Enum.reduce(result[:rows], %{hour: [], temp: []}, fn({hour, temp}, dict) ->
      %{hour: dict[:hour] ++ [hour], temp: dict[:temp] ++ [temp]}
    end)
  end
  
  def yesterday do
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
        GROUP BY
          hour
        ORDER BY
          hour
        ;
        """, []
      )
    
    Enum.reduce(result[:rows], %{hour: [], temp: []}, fn({hour, temp}, dict) ->
      %{hour: dict[:hour] ++ [hour], temp: dict[:temp] ++ [temp]}
    end)
  end
end