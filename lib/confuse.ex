defmodule Confuse do
  @moduledoc """
  Parse config files based on the libconfuse format.
  """

  @doc """
  Parse a configuration string into a structured map.
  """
  @spec parse(data :: String.t()) :: {:ok, map()} | {:error, :parsing_failed}
  def parse(data) do
    with {:ok, tokens, _end_line} <- :confuse_lexer.string(String.to_charlist(data)),
         {:ok, parsed} <- :confuse_parser.parse(tokens) do
      {:ok, make_nice(parsed)}
    else
      _ -> {:error, :parsing_failed}
    end
  end

  defp make_nice(statements) do
    statements
    |> Enum.map(fn
      {:kv, key, {:string, value}} ->
        {key, value}

      {:kv, key, {:integer, value}} ->
        {key, value}

      {:kv, key, {:tuple, items}} ->
        {key, items}

      {:block, tag, label, body} ->
        {{tag, label}, make_nice(body)}

      {:function_call, name, args} ->
        {{:function, name}, flatten_args(args)}
    end)
    |> Map.new()
  end

  defp flatten_args(args) do
    Enum.flat_map(args, fn
      v when is_binary(v) -> String.to_charlist(v)
      v when is_integer(v) -> [v]
    end)
  end
end
