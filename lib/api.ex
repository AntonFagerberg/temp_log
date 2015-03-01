defmodule TempLog.API do
  use Plug.Router
  
  plug Plug.Static, at: "/public", from: "pub"
  plug :match
  plug :dispatch
  
  get "/" do
    template = EEx.eval_file("lib/index.eex")
    
    conn
    |> send_resp(200, template)
  end
  
  get "/api/current" do
    json_response = TempLog.Query.current |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
    
  get "/api/minute" do
    json_response = TempLog.Query.minute |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
    
  get "/api/today" do
    json_response = TempLog.Query.today |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
    
  get "/api/yesterday" do
    json_response = TempLog.Query.yesterday |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
  
  get "/api/week" do
    json_response = TempLog.Query.week |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
  
  get "/api/month" do
    json_response = TempLog.Query.month |> Poison.encode!
    
    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, json_response)
  end
end