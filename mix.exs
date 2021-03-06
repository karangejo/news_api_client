defmodule NewsApiClient.MixProject do
  use Mix.Project

  def project do
    [
      app: :news_api_client,
      version: "0.1.1",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      source_url: "https://github.com/karangejo/news_api_client",
      name: "news_api_client",
      docs: [main: "NewsApiClient",
            extras: ["README.md"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description do
    "An interface to the News API"
  end

  defp package do
    [
      name: "news_api_client",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/karangejo/news_api_client"}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:poison, "~> 3.1"},
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
