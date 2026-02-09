defmodule Confuse.MixProject do
  use Mix.Project

  def project() do
    [
      app: :confuse,
      version: "0.3.1",
      elixir: "~> 1.1",
      compilers: [:leex, :yecc] ++ Mix.compilers(),
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      consolidate_protocols: Mix.env() != :dev,
      deps: deps(),

      # Docs
      name: "Confuse",
      description: "Configuration parser for libconfuse style config files.",
      source_url: "https://github.com/underjord/confuse",
      docs: [
        # The main page in the docs
        main: "readme",
        extras: ["README.md"]
      ],
      package: [
        name: :confuse,
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/underjord/confuse"}
      ],
      aliases: aliases(),
      dialyzer: dialyzer()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application() do
    [
      extra_applications: [:logger]
    ]
  end

  def docs() do
    [
      main: "readme",
      extras: ["README.md"]
    ]
  end

  def package() do
    [
      name: :confuse,
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => "https://github.com/underjord/confuse"}
    ]
  end

  def aliases() do
    [
      check: [
        "hex.audit",
        "compile --warnings-as-errors --force",
        "format --check-formatted",
        "credo --strict",
        "deps.unlock --check-unused",
        "dialyzer"
      ]
    ]
  end

  def dialyzer() do
    [
      plt_add_apps: [:mix],
      ignore_warnings: ".dialyzer_ignore.exs"
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps() do
    [
      {:nstandard, "~> 0.1"},
      {:quokka, "~> 2.0", only: [:dev]},
      {:igniter, "~> 0.5", optional: true, runtime: false},
      {:ex_doc, "~> 0.31", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:spellweaver, "~> 0.1", only: [:dev, :test], runtime: false}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
