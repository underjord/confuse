defmodule Confuse.FwupTest do
  use ExUnit.Case

  test "detect which fwup files have deltas" do
    assert {:ok,
            %{
              "upgrade.a" => ["config.txt", "rootfs.img"],
              "upgrade.b" => ["config.txt", "rootfs.img"]
            }} =
             Confuse.Fwup.get_delta_files("test/fixtures/with_deltas.conf")
  end

  test "capture all detail about a fwup file with deltas and encryption" do
    assert {:ok,
            %{
              deltas?: true,
              raw?: true,
              fat?: true,
              encryption?: false
            }} =
             Confuse.Fwup.get_delta_details("test/fixtures/with_deltas.conf")

    assert {:ok,
            %{
              "upgrade.a" => %{
                "config.txt" => %{delta: true, type: :fat, encrypted: true},
                "roofs.img" => %{delta: true, type: :raw, encrypted: true}
              },
              "upgrade.b" => %{
                "config.txt" => %{delta: true, type: :fat, encrypted: true},
                "roofs.img" => %{delta: true, type: :raw, encrypted: true}
              }
            }} =
             Confuse.Fwup.get_delta_details("test/fixtures/with_deltas_encrypted.conf")
  end

  @tag :tmp_dir
  test "fail to load file", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "foo.conf")
    assert {:error, :enoent} = Confuse.Fwup.get_delta_files(path)
  end
end
