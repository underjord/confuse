defmodule Confuse do
  @moduledoc """
  """

  import NimbleParsec
  import Confuse.Helpers

  defcombinator(
    :statement,
    repeat(
      choice([
        block(),
        function_call(),
        kv(),
        blank(),
        comment(),
        multiline_comment()
      ])
      |> ignore(whitespace_or_end())
    )
  )

  defparsec(:parser, config())

  def parse(data) do
    case parser(data) do
      {:ok, parsed, _remainder, _, _, _} ->
        {:ok, make_nice(parsed)}

      {:error, _} ->
        {:error, :parsing_failed}
    end
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
