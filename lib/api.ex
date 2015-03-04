defmodule TempLog.API do
  use Plug.Router
  
  plug Plug.Static, at: "/public", from: "pub"
  plug :match
  plug :dispatch
  
  get "/" do
    template = EEx.eval_file("lib/templates/index.eex")
    send_resp(conn, 200, template)
  end
  
  get "/api/sensors" do
    json_response = TempLog.Query.sensors |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
  
  get "/api/:sensor/current" do
    json_response = TempLog.Query.current(sensor) |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
    
  get "/api/:sensor/minute" do
    json_response = TempLog.Query.minute(sensor) |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
    
  get "/api/:sensor/today" do
    json_response = TempLog.Query.today(sensor) |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
    
  get "/api/:sensor/yesterday" do
    json_response = TempLog.Query.yesterday(sensor) |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
  
  get "/api/:sensor/week" do
    json_response = TempLog.Query.week(sensor) |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
  
  get "/api/:sensor/month" do
    json_response = TempLog.Query.month(sensor) |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
  
  match _ do
   send_resp(conn, 404, "oops")
  end
end