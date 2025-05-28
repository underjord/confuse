defmodule Confuse.Helpers do
  import NimbleParsec

  def key_char, do: repeat(ascii_char([?a..?z, ?A..?Z, ?0..?9, ?-, ?_, ?.]))
  def bare_string, do: repeat(ascii_char([?a..?z, ?A..?Z, ?0..?9, ?-, ?_, ?., ?$, ?{, ?}]))
  def single_any_char, do: ascii_char([32..126])

  def string_except_double_quotes,
    do:
      repeat(
        choice([
          ascii_char([32..33, 35..126]),
          # allow \"
          string("\\\"")
        ])
      )

  def string_except_single_quotes, do: repeat(ascii_char([32..38, 40..126]))

  def spaces_and_tabs, do: repeat(choice([string(" "), string("\t")]))

  def single_whitespace, do: choice([string(" "), string("\t"), string("\n")])

  def whitespace, do: repeat(single_whitespace())

  def whitespace_or_end, do: repeat(choice([string(" "), string("\t"), string("\n")]))

  def separated_string, do: choice([quoted_string(), key_char()])

  def quoted_string,
    do:
      choice([
        ignore(string("\"")) |> concat(string_except_double_quotes()) |> ignore(string("\"")),
        ignore(string("'")) |> concat(string_except_single_quotes()) |> ignore(string("'"))
      ])

  def quoted_string(combinator) do
    combinator
    |> choice([
      ignore(string("\"")) |> concat(string_except_double_quotes()) |> ignore(string("\"")),
      ignore(string("'")) |> concat(string_except_single_quotes()) |> ignore(string("'"))
    ])
  end

  def tuple_item,
    do:
      quoted_string()
      |> ignore(whitespace())
      |> ignore(optional(string(",")))
      |> ignore(whitespace())

  def tuple,
    do:
      ignore(string("{"))
      |> ignore(whitespace())
      |> repeat(tuple_item() |> wrap())
      |> ignore(whitespace())
      |> ignore(string("}"))
      |> ignore(whitespace_or_end())

  def arg,
    do:
      choice([
        quoted_string() |> ignore(choice([string(","), string(")")])),
        optional(string("-")) |> integer(min: 1) |> ignore(choice([string(","), string(")")])),
        bare_string() |> ignore(choice([string(","), string(")")]))
      ])
      |> ignore(whitespace())

  def blank,
    do: ignore(single_whitespace())

  def comment,
    do:
      ignore(choice([string("#"), string("// "), string("///"), string("//")]))
      |> repeat(ascii_char([{:not, 10}]))
      |> ignore(ascii_char([10]))
      |> tag(:comment)
      |> ignore(whitespace_or_end())

  def multiline_comment,
    do:
      ignore(string("/*"))
      |> repeat(single_any_char())
      |> string("*/")
      |> tag(:comment)
      |> ignore(whitespace_or_end())

  def args,
    do:
      ignore(string("("))
      |> ignore(whitespace())
      |> repeat(arg())
      |> tag(:args)

  def function_call,
    do:
      key_char()
      |> tag(:function)
      |> concat(args())
      |> tag(:function_call)
      |> ignore(whitespace_or_end())

  def value,
    do:
      choice([
        quoted_string() |> tag(:string),
        # Only grab integer if terminated by whitespace
        integer(min: 1) |> ignore(single_whitespace()) |> unwrap_and_tag(:integer),
        tuple() |> tag(:tuple),
        bare_string() |> tag(:string)
      ])

  def key,
    do:
      key_char()
      |> ignore(spaces_and_tabs())
      |> ignore(string("="))
      |> ignore(spaces_and_tabs())

  def block_start_with_label,
    do:
      key_char()
      |> tag(:tag)
      |> ignore(spaces_and_tabs())
      |> concat(block_label())
      |> ignore(spaces_and_tabs())
      |> ignore(string("{"))
      |> ignore(whitespace())

  def block_label,
    do:
      separated_string()
      |> tag(:label)

  def block_start_no_label,
    do:
      key_char()
      |> tag(:tag)
      |> ignore(spaces_and_tabs())
      |> ignore(string("{"))
      |> ignore(whitespace())

  def block_start,
    do:
      choice([
        block_start_with_label(),
        block_start_no_label()
      ])

  def kv,
    do:
      key()
      |> tag(:key)
      |> concat(value())
      |> tag(:kv)
      |> ignore(whitespace_or_end())

  def block_body(),
    do:
      parsec({Confuse, :statement})
      |> tag(:body)
      |> ignore(whitespace_or_end())
      |> ignore(string("}"))

  def block,
    do:
      block_start()
      |> concat(block_body())
      |> tag(:block)

  def config,
    do: parsec({Confuse, :statement})
end
