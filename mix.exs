defmodule TempLog.Mixfile do
  use Mix.Project

  def project do
    [app: :temp_log,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  def application do
    [
      applications: [
        :logger,
        :postgrex,
        :ecto,
        :cowboy,
        :plug
      ],
      mod: {TempLog.Main, []}
    ]
  end

  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 0.12"},
      {:poison, "~> 1.4"},
      {:postgrex, "~> 0.8"},
      {:ecto, "~> 0.11"}
    ]
  end
end
