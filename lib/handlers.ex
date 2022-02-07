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
    Enum.map(results, fn x -> Poison.encode!(x) end)
  end

  def handle_post_mood ({:ok, body, conn}) do
    IO.puts "TODO"
    case Bbdrop.Repo.insert %Posting{
          location: (to_string(:inet_parse.ntoa(conn.remote_ip))),
          mood: body,
          inserted_at: (DateTime.utc_now())} do
      {:ok, _struct} -> (Plug.Conn.send_resp conn, 200, "Okay")
      {:error, _changeset} -> (Plug.Conn.send_resp conn, 404, "Something went wrong")
    end
  end
  
end 
