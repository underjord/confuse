# Confuse

An all-Elixir parser for libconfuse style config files.

It is primarily made to serve the Nerves ecosystem as our firmware update tool
of choice, `fwup`, uses libconfuse for config. Happy to expand capability over
time.

## Installation

Most easily installed with Igniter:

```sh
mix archive.install hex igniter_new && mix igniter.install confuse
```

The package can be installed by adding `confuse` to your list of dependencies
in `mix.exs`:

```elixir
def deps do
  [
    {:confuse, "~> 0.1.0"}
  ]
end
```

## Usage

Parsing a file produces a map that is the structured form of the config file.
The structured form can still be a bit unwieldy, open to suggestions on
making it nicer.

```elixir
{:ok, parsed} =
  "fwup.conf"
  |> File.read!()
  |> Confuse.parse()
```
