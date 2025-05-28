defmodule Confuse.FwupTest do
  use ExUnit.Case

  test "detect which fwup files have deltas" do
    assert %{
             "upgrade.a" => ["config.txt", "rootfs.img"],
             "upgrade.b" => ["config.txt", "rootfs.img"]
           } =
             Confuse.Fwup.get_delta_files("test/fixtures/with_deltas.conf")
  end
end
