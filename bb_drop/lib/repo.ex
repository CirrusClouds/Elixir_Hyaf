defmodule Bbdrop.Repo do
  use Ecto.Repo,
    otp_app: :bbdrop,
    adapter: Ecto.Adapters.Postgres
end
