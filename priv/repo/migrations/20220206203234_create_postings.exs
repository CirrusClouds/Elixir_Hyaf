defmodule Helloplug.Repo.Migrations.CreatePostings do
  use Ecto.Migration

  def change do
    create table(:postings) do
      add :location, :string
      add :mood, :string

      timestamps()
    end
    
  end
end
