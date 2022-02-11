defmodule Bbdrop.Handlers do
  import Ecto.Query
  @moduledoc """
  Handlers for the APIs
  """
  
  def handle_get_recent_postings (_conn) do
    query = from p in Posting,
      select: p,
      order_by: [desc: p.inserted_at]
    results = (Bbdrop.Repo.all(query))
    Poison.encode!(results)
  end

  def handle_post_mood ({:ok, body, conn}) do
    IO.puts "Posting your mood"
    location_info = get_location_info(conn.remote_ip)
    case location_info["status"] do
      "success" ->
        case Bbdrop.Repo.insert %Posting{
              ip: location_info["query"],
              mood: body,
              iso: location_info["countryCode"],
            city: location_info["city"],
              inserted_at: (NaiveDateTime.local_now())} do
          {:ok, _struct} -> (Plug.Conn.send_resp conn, 200, "Okay")
          {:error, _changeset} -> (Plug.Conn.send_resp conn, 404, "Something went wrong")
        end
      _ -> (Plug.Conn.send_resp conn, 200, location_info[:status])
    end
  end

  def get_location_info(ip) do
    ip_string = to_string(:inet_parse.ntoa(ip))
    if ip_string == "127.0.0.1" do
      ip_string = "206.71.50.230"
      url = "http://ip-api.com/json/#{ip_string}"
      IO.puts url
      {:ok, response} = HTTPoison.get(url)
      Poison.decode!(response.body)
      
    else
      url = "http://ip-api.com/json/#{ip_string}"
      IO.puts url
      {:ok, response} = HTTPoison.get(url)
      Poison.decode!(response.body)
    end
  end

  def handle_get_postings_by_location(_conn, country) do
    query = from p in Posting,
      where: p.iso == ^country,
      select: p,
      order_by: [desc: p.inserted_at]
    results = (Bbdrop.Repo.all(query))
    Enum.map(results, fn x -> Poison.encode!(x) end)
  end

  def handle_get_postings_by_location(_conn, country, city) do
    query = from p in Posting,
      where: p.city == ^city and p.iso == ^country,
      select: p,
      order_by: [desc: p.inserted_at]
    results = (Bbdrop.Repo.all(query))
    Enum.map(results, fn x -> Poison.encode!(x) end)
  end

end 
