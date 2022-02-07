defmodule Posting do
  use Ecto.Schema

  schema "postings" do
    # id field is implicit
    field :location, :string
    field :mood, :string
    timestamps()
  end
end
