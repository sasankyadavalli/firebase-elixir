defmodule Firebase.Mixfile do
  use Mix.Project

  def project do
    [
      app: :firebase,
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: ["coveralls": :test, "coveralls.detail": :test, "coveralls.post": :test, "coveralls.html": :test]
    ]
  end

  def application do
    [
      extra_applications: [:logger, :faker]
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 0.13.0"},
      {:poison, "~> 3.1"},
      {:faker, "~> 0.8"},
      {:excoveralls, "~> 0.7", only: :test},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
      {:msg91, git: "https://github.com/sasankyadavalli/msg91"},
    ]
  end
end
