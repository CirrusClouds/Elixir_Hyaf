defmodule Bbdrop do
  @moduledoc """
  Documentation for `Helloplug`.
  """
  use Plug.Builder
  
  def init(default_opts) do
    IO.puts "starting up application..."
    Bbdrop.Repo.start_link
    default_opts
  end

  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end

  def route("OPTIONS", _path, conn) do
    conn = Plug.Conn.put_resp_header(conn, "Access-Control-Allow-Origin", "*") 
    conn = Plug.Conn.put_resp_header(conn, "Access-Control-Allow-Methods", "GET, PUT, POST, DELETE, CREATE, HEAD, OPTIONS") 
    conn = Plug.Conn.put_resp_header(conn, "Access-Control-Allow-Headers", "Content-Type, Authorization, Accept, Accept-Language, X-Authorization") 
    conn  |> (Plug.Conn.send_resp 204, "")
    
  end

  def route("GET", ["recent_postings"], conn) do
    IO.puts "getting Recent Postings!"
    conn = Plug.Conn.put_resp_header(conn, "Access-Control-Allow-Origin", "*") 
    conn = Plug.Conn.put_resp_header(conn, "Allow", "GET, PUT, POST, DELETE, CREATE, HEAD"
    )
    results = Bbdrop.Handlers.handle_get_recent_postings(conn)
    conn  |> (Plug.Conn.send_resp 200, results)
  end

  def route("POST", _path, conn) do
    IO.puts "Making a posting"
    conn = Plug.Conn.put_resp_header(conn, "Access-Control-Allow-Origin", "*") 
    conn = Plug.Conn.put_resp_header(conn, "Allow", "GET, PUT, POST, DELETE, CREATE, HEAD")
    Bbdrop.Handlers.handle_post_mood (Plug.Conn.read_body(conn))
  end

  def route("GET", ["near_me", country, city], conn) do
    IO.puts "Getting analytics for #{city}, #{country}"
    results = Bbdrop.Handlers.handle_get_postings_by_location(conn, country, city)
    conn |> (Plug.Conn.send_resp 200, results)
  end

  def route("GET", ["near_me", country], conn) do
    IO.puts "Getting analytics for #{country}"
    results = Bbdrop.Handlers.handle_get_postings_by_location(conn, country)
    conn |> (Plug.Conn.send_resp 200, results)    
  end

  def route(_method, _path, conn) do
    conn |> (Plug.Conn.send_resp 404, "Couldn't find that page")
  end
    
  def main (_args \\ []) do
    {:ok, _conn} = Plug.Adapters.Cowboy.http Bbdrop, []
  end
  
end

