defmodule TempLog.Mixfile do
  use Mix.Project

  def project do
    [app: :temp_log,
     version: "0.0.1",
     elixir: "~> 1.0",
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      applications: [
        :logger,
        :postgrex,
        :ecto,
        :cowboy,
        :plug
      ],
      mod: {TempLog, []}
    ]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [
      {:cowboy, "~> 1.0"},
      {:plug, "~> 0.10"},
      {:poison, "~> 1.3"},
      {:postgrex, "0.7.0"},
      {:ecto, "~> 0.8.1"}
    ]
  end
end
