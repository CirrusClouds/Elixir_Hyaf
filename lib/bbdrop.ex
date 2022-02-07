defmodule Bbdrop do
  @moduledoc """
  Documentation for `Helloplug`.
  """
  
  def init(default_opts) do
    IO.puts "starting up Helloplug..."
    Bbdrop.Repo.start_link
    default_opts
  end

  def call(conn, _opts) do
    route(conn.method, conn.path_info, conn)
  end

  def route("GET", ["hello"], conn) do
    IO.puts "saying Hello!"
    conn  |> (Plug.Conn.send_resp 200, "Hello, world!")
  end

  def route("GET", ["recent_postings"], conn) do
    IO.puts "getting Recent Postings!"
    results = Bbdrop.Handlers.handle_get_recent_postings(conn)
    conn  |> (Plug.Conn.send_resp 200, results)
  end

  def route("POST", _path, conn) do
    IO.puts "Making a posting"
    Bbdrop.Handlers.handle_post_mood (Plug.Conn.read_body(conn))
    end
    

  def route(_method, _path, conn) do
    conn |> (Plug.Conn.send_resp 404, "Couldn't find that page")
  end
    
  def main (_args \\ []) do
    {:ok, _conn} = Plug.Adapters.Cowboy.http Bbdrop, []
  end
  
end
