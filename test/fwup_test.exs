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

  test "detect fwup file features, only raw deltas" do
    conf_version = Version.parse!("0.5.0")
    raw_delta_version = Version.parse!("1.6.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: true,
              fat_deltas?: false,
              encryption?: false,
              encrypted_deltas?: false,
              complete_fwup_version: ^conf_version,
              delta_fwup_version: ^raw_delta_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/raw_deltas.conf")
  end

  test "detect fwup file features, only FAT deltas" do
    conf_version = Version.parse!("0.6.0")
    fat_delta_version = Version.parse!("1.10.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: false,
              fat_deltas?: true,
              encryption?: false,
              encrypted_deltas?: false,
              complete_fwup_version: ^conf_version,
              delta_fwup_version: ^fat_delta_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/fat_deltas.conf")
  end

  test "detect fwup file features, raw and FAT deltas" do
    conf_version = Version.parse!("0.7.0")
    fat_delta_version = Version.parse!("1.10.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: true,
              fat_deltas?: true,
              encryption?: false,
              encrypted_deltas?: false,
              complete_fwup_version: ^conf_version,
              delta_fwup_version: ^fat_delta_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/with_deltas.conf")

    # TODO: Ensure the required version from fwup conf overrides the calculated minimum
    # TODO: Ensure we have tests for that
  end

  test "detect fwup file features, encrypted, no deltas" do
    encrypted_version = Version.parse!("1.5.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: false,
              fat_deltas?: false,
              encryption?: true,
              encrypted_deltas?: false,
              complete_fwup_version: ^encrypted_version,
              delta_fwup_version: ^encrypted_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/encrypted.conf")
  end

  test "detect fwup file features, encrypted (raw) deltas" do
    encrypted_version = Version.parse!("1.5.0")
    encrypted_delta_version = Version.parse!("1.13.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: true,
              fat_deltas?: true,
              encryption?: true,
              encrypted_deltas?: true,
              complete_fwup_version: ^encrypted_version,
              delta_fwup_version: ^encrypted_delta_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/with_encrypted_deltas.conf")
  end

  test "detect fwup file features, high version requirement, no features" do
    conf_version = Version.parse!("1.13.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: false,
              fat_deltas?: false,
              encryption?: false,
              encrypted_deltas?: false,
              complete_fwup_version: ^conf_version,
              delta_fwup_version: ^conf_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/high_requirement.conf")
  end

  test "no features, no requirements" do
    complete_version = Version.parse!("0.2.0")
    delta_version = Version.parse!("1.6.0")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: false,
              fat_deltas?: false,
              encryption?: false,
              encrypted_deltas?: false,
              complete_fwup_version: ^complete_version,
              delta_fwup_version: ^delta_version
            }} =
             Confuse.Fwup.get_feature_usage("test/fixtures/blank.conf")
  end

  @tag :tmp_dir
  test "fail to load file", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "foo.conf")
    assert {:error, :enoent} = Confuse.Fwup.get_delta_files(path)
  end
end
