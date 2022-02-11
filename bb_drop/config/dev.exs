import Config

config :bbdrop,
  ecto_repos: [Bbdrop.Repo]

config :bbdrop, Bbdrop.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "postgres",
  hostname: "localhost",
  user: "postgres",
  password: ""
  
