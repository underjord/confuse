defmodule ConfuseTest do
  use ExUnit.Case

  doctest Confuse

  # add "libconfuse-test"

  test "parse rpi4-meta sample" do
    test_parse_sample("rpi4-meta")
  end

  test "parse rpi4-fwup sample" do
    output = test_parse_sample("rpi4-fwup")
    # Just make sure the final block was in the parsed result
    assert inspect(output, limit: :infinity) =~ "provision.wrongplatform"
  end

  defp test_parse_sample(config) do
    {data, _} = "test/fixtures/#{config}.exs" |> Code.eval_file()
    cfg = "test/fixtures/#{config}.conf" |> File.read!()

    assert {:ok, output} = Confuse.parse(cfg)

    if output != data do
      # This is helpful output when fixing things
      IO.puts("Error in #{config}")
      IO.puts(inspect(output, limit: :infinity, label: config))
    end

    assert output == data
    output
  end
end
