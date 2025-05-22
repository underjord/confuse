defmodule ConfuseTest do
  use ExUnit.Case
  doctest Confuse

  @configs [
    "rpi4-meta",
    "rpi4-fwup"
    # "libconfuse-test"
  ]

  test "parse sample" do
    @configs
    |> Enum.each(fn config ->
      {data, _} = "test/fixtures/#{config}.exs" |> Code.eval_file()
      cfg = "test/fixtures/#{config}.conf" |> File.read!()

      assert {:ok, output} = Confuse.parse(cfg)

      if output != data do
        IO.puts("Error in #{config}")
        IO.inspect(output, limit: :infinity, label: config)
      end

      assert output == data
    end)
  end
end
