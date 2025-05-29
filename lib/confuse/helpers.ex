defmodule Confuse.Helpers do
  @moduledoc false
  import NimbleParsec

  @spec key_char() :: NimbleParsec.t()
  def key_char(), do: repeat(ascii_char([?a..?z, ?A..?Z, ?0..?9, ?-, ?_, ?.]))
  @spec bare_string() :: NimbleParsec.t()
  def bare_string(), do: repeat(ascii_char([?a..?z, ?A..?Z, ?0..?9, ?-, ?_, ?., ?$, ?{, ?}]))
  @spec single_any_char() :: NimbleParsec.t()
  def single_any_char(), do: ascii_char([32..126])

  # allow \"
  @spec string_except_double_quotes() :: NimbleParsec.t()
  def string_except_double_quotes(),
    do: repeat(choice([ascii_char([32..33, 35..126]), string("\\\"")]))

  @spec string_except_single_quotes() :: NimbleParsec.t()
  def string_except_single_quotes(), do: repeat(ascii_char([32..38, 40..126]))

  @spec spaces_and_tabs() :: NimbleParsec.t()
  def spaces_and_tabs(), do: repeat(choice([string(" "), string("\t")]))

  @spec single_whitespace() :: NimbleParsec.t()
  def single_whitespace(), do: choice([string(" "), string("\t"), string("\n")])

  @spec whitespace() :: NimbleParsec.t()
  def whitespace(), do: repeat(single_whitespace())

  @spec whitespace_or_end() :: NimbleParsec.t()
  def whitespace_or_end(), do: repeat(choice([string(" "), string("\t"), string("\n")]))

  @spec separated_string() :: NimbleParsec.t()
  def separated_string(), do: choice([quoted_string(), key_char()])

  @spec quoted_string() :: NimbleParsec.t()
  def quoted_string(),
    do:
      choice([
        ignore(string("\"")) |> concat(string_except_double_quotes()) |> ignore(string("\"")),
        ignore(string("'")) |> concat(string_except_single_quotes()) |> ignore(string("'"))
      ])

  @spec quoted_string(NimbleParsec.t()) :: NimbleParsec.t()
  def quoted_string(combinator) do
    combinator
    |> choice([
      ignore(string("\"")) |> concat(string_except_double_quotes()) |> ignore(string("\"")),
      ignore(string("'")) |> concat(string_except_single_quotes()) |> ignore(string("'"))
    ])
  end

  @spec tuple_item() :: NimbleParsec.t()
  def tuple_item(),
    do:
      quoted_string()
      |> ignore(whitespace())
      |> ignore(optional(string(",")))
      |> ignore(whitespace())

  @spec tuple() :: NimbleParsec.t()
  def tuple(),
    do:
      ignore(string("{"))
      |> ignore(whitespace())
      |> repeat(tuple_item() |> wrap())
      |> ignore(whitespace())
      |> ignore(string("}"))
      |> ignore(whitespace_or_end())

  @spec arg() :: NimbleParsec.t()
  def arg(),
    do:
      choice([
        quoted_string() |> ignore(choice([string(","), string(")")])),
        optional(string("-")) |> integer(min: 1) |> ignore(choice([string(","), string(")")])),
        bare_string() |> ignore(choice([string(","), string(")")]))
      ])
      |> ignore(whitespace())

  @spec blank() :: NimbleParsec.t()
  def blank(), do: ignore(single_whitespace())

  @spec comment() :: NimbleParsec.t()
  def comment(),
    do:
      ignore(choice([string("#"), string("// "), string("///"), string("//")]))
      |> repeat(ascii_char([{:not, 10}]))
      |> ignore(ascii_char([10]))
      |> tag(:comment)
      |> ignore(whitespace_or_end())

  @spec multiline_comment() :: NimbleParsec.t()
  def multiline_comment(),
    do:
      ignore(string("/*"))
      |> repeat(single_any_char())
      |> string("*/")
      |> tag(:comment)
      |> ignore(whitespace_or_end())

  @spec args() :: NimbleParsec.t()
  def args(), do: ignore(string("(")) |> ignore(whitespace()) |> repeat(arg()) |> tag(:args)

  @spec function_call() :: NimbleParsec.t()
  def function_call(),
    do:
      key_char()
      |> tag(:function)
      |> concat(args())
      |> tag(:function_call)
      |> ignore(whitespace_or_end())

  # Only grab integer if terminated by whitespace
  @spec value() :: NimbleParsec.t()
  def value(),
    do:
      choice([
        quoted_string() |> tag(:string),
        integer(min: 1) |> ignore(single_whitespace()) |> unwrap_and_tag(:integer),
        tuple() |> tag(:tuple),
        bare_string() |> tag(:string)
      ])

  @spec key() :: NimbleParsec.t()
  def key(),
    do:
      key_char() |> ignore(spaces_and_tabs()) |> ignore(string("=")) |> ignore(spaces_and_tabs())

  @spec block_start_with_label() :: NimbleParsec.t()
  def block_start_with_label(),
    do:
      key_char()
      |> tag(:tag)
      |> ignore(spaces_and_tabs())
      |> concat(block_label())
      |> ignore(spaces_and_tabs())
      |> ignore(string("{"))
      |> ignore(whitespace())

  @spec block_label() :: NimbleParsec.t()
  def block_label(), do: separated_string() |> tag(:label)

  @spec block_start_no_label() :: NimbleParsec.t()
  def block_start_no_label(),
    do:
      key_char()
      |> tag(:tag)
      |> ignore(spaces_and_tabs())
      |> ignore(string("{"))
      |> ignore(whitespace())

  @spec block_start() :: NimbleParsec.t()
  def block_start(), do: choice([block_start_with_label(), block_start_no_label()])

  @spec kv() :: NimbleParsec.t()
  def kv(), do: key() |> tag(:key) |> concat(value()) |> tag(:kv) |> ignore(whitespace_or_end())

  @spec block_body() :: NimbleParsec.t()
  def block_body(),
    do:
      parsec({Confuse, :statement})
      |> tag(:body)
      |> ignore(whitespace_or_end())
      |> ignore(string("}"))

  @spec block() :: NimbleParsec.t()
  def block(), do: block_start() |> concat(block_body()) |> tag(:block)

  @spec config() :: NimbleParsec.t()
  def config(), do: parsec({Confuse, :statement})
end
