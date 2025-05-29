defmodule Confuse do
  @moduledoc """
  Parse config files based on the libconfuse format.
  """

  import Confuse.Helpers
  import NimbleParsec

  defcombinator(
    :statement,
    choice([
      block(),
      function_call(),
      kv(),
      blank(),
      comment(),
      multiline_comment()
    ])
    |> ignore(whitespace_or_end())
    |> repeat()
  )

  defparsec(:parser, config())

  @doc """
  Parse a configuration string into a structured map.
  """
  @spec parse(data :: String.t()) :: {:ok, map()} | {:error, :parsing_failed}
  def parse(data) do
    {:ok, parsed, _remainder, _, _, _} = parser(data)
    {:ok, make_nice(parsed)}
  end

  defp make_nice(parsed) do
    parsed
    |> Enum.map(fn line ->
      case line do
        {:function_call, [function: name, args: args]} ->
          {{:function, to_string(name)}, args}

        {:comment, _} ->
          nil

        # integer
        {:kv, [key: key, integer: value]} ->
          {to_string(key), value}

        # charlist string
        {:kv, [key: key, string: value]} ->
          {to_string(key), to_string(value)}

        {:kv, [key: key, tuple: value]} ->
          {to_string(key), Enum.map(value, &to_string/1)}

        {:block, [tag: tag, label: label, body: body]} ->
          {{to_string(tag), to_string(label)}, make_nice(body)}

        {:block, [tag: tag, body: body]} ->
          {to_string(tag), make_nice(body)}
      end
    end)
    |> Enum.reject(&is_nil/1)
    |> Map.new()
  end
end
