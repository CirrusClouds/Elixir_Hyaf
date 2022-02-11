defmodule Posting do
  use Ecto.Schema

  schema "postings" do
    # id field is implicit
    @primary_key {:id, :binary_id, autogenerate: true}
    field :ip, :string
    field :mood, :string
    field :iso, :string
    field :city, :string
    timestamps()
  end
end
