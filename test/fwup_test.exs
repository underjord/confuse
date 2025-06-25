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

  test "detect fwup file features" do
    fat_delta_version = Version.parse!("1.10.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: true,
              fat_deltas?: true,
              encryption?: false,
              encrypted_deltas?: false,
              require_fwup_version: ^fat_delta_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/with_deltas.conf")

    encrypted_delta_version = Version.parse!("1.13.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: true,
              fat_deltas?: true,
              encryption?: true,
              encrypted_deltas?: true,
              require_fwup_version: ^encrypted_delta_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/with_encrypted_deltas.conf")
  end

  @tag :tmp_dir
  test "fail to load file", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "foo.conf")
    assert {:error, :enoent} = Confuse.Fwup.get_delta_files(path)
  end
end
