defmodule Bbdrop.Repo.Migrations.CreateTable do
  use Ecto.Migration

  def change do
    create table("postings") do
      add :ip, :string
      add :mood, :string
      add :iso, :string
      add :city, :string
      timestamps()
    end
  end
end
