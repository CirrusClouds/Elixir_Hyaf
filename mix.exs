defmodule Bbdrop.MixProject do
  use Mix.Project

  def project do
    [
      app: :bbdrop,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: escript(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      # [applications: [:logger, :cowboy, :plug]]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:cowboy, ">=0.0.0"},
      {:plug_cowboy, ">=0.0.0"},
      {:plug, ">=0.0.0"},
      {:ecto, ">=0.0.0"},
      {:ecto_sql, ">=0.0.0"},
      {:postgrex, ">=0.0.0"},
      {:poison, ">=0.0.0"},
      {:telemetry, ">=0.0.0"},
    ]
  end

  defp escript do
    [main_module: Bbdrop]
  end
  
end
