defmodule BbdropTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "returns list" do
    Bbdrop.init([])
    conn = conn(:get, "/recent_postings")
    conn = Bbdrop.call(conn, Bbdrop.init([]))
    
    assert conn.state == :sent
    assert conn.status == 200
    assert String.match?(conn.resp_body, ~r/127.0.0.1/)
  end
end
