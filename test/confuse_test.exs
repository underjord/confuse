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
      IO.puts("Error in #{config}")
      IO.inspect(output, limit: :infinity, label: config)
    end

    if output != data do
      File.write("#{config}.txt", inspect(output, limit: :infinity))
    end

    assert output == data
    output
  end
end
