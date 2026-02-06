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

  test "detect which fwup files have deltas without file access" do
    conf = File.read!("test/fixtures/with_deltas.conf")

    assert {:ok,
            %{
              "upgrade.a" => ["config.txt", "rootfs.img"],
              "upgrade.b" => ["config.txt", "rootfs.img"]
            }} =
             Confuse.Fwup.get_delta_files_from_config(conf)
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

  test "detect fwup file features, only raw deltas without file access" do
    conf_version = Version.parse!("0.5.0")
    raw_delta_version = Version.parse!("1.6.0")
    conf = File.read!("test/fixtures/raw_deltas.conf")

    assert {:ok,
            %Confuse.Fwup.Features{
              raw_deltas?: true,
              fat_deltas?: false,
              encryption?: false,
              encrypted_deltas?: false,
              complete_fwup_version: ^conf_version,
              delta_fwup_version: ^raw_delta_version
            }} =
             Confuse.Fwup.get_feature_usage_from_config(conf)
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

  test "validate delta, essentially all configs work with themselves" do
    ~w(
    blank.conf
    fat_deltas.conf
    high_requirement.conf
    rpi4-fwup.conf
    rpi4-meta.conf
    with_deltas.conf
    encrypted.conf
    libconfuse-test.conf
    raw_deltas.conf
    with_encrypted_deltas.conf)
    |> Enum.each(fn file ->
      conf = File.read!(Path.join("test/fixtures", file))
      assert {:ok, ^file} = {Confuse.Fwup.validate_delta(conf, conf), file}
    end)
  end

  test "validate firmware packaged meta.conf, rpi4, no fat_write" do
    source_conf = File.read!("test/fixtures/rpi4-meta-no-fat-write.conf")
    target_conf = File.read!("test/fixtures/rpi4-meta-fat-delta.conf")
    assert {:error, [err]} = Confuse.Fwup.validate_delta(source_conf, target_conf)

    assert err =~
             "Target uses FAT deltas but source has no FAT writes"
  end

  test "validate firmware packaged meta.conf, rpi4, no raw_write" do
    source_conf = File.read!("test/fixtures/rpi4-meta-no-raw-write.conf")
    target_conf = File.read!("test/fixtures/rpi4-meta.conf")
    assert {:error, [err]} = Confuse.Fwup.validate_delta(source_conf, target_conf)

    assert err =~
             "Target uses raw deltas but source has no raw writes"
  end

  test "validate delta, target uses raw deltas, source firmware is encrypted target firmware missing encrypted deltas" do
    source_conf = File.read!("test/fixtures/encrypted.conf")
    target_conf = File.read!("test/fixtures/with_deltas.conf")
    assert {:error, [err]} = Confuse.Fwup.validate_delta(source_conf, target_conf)

    assert err =~
             "Target uses raw deltas and source firmware uses encryption for the same resource"
  end

  test "validate delta, target uses raw encrypted deltas, low fwup version" do
    source_conf = File.read!("test/fixtures/with_encrypted_deltas.conf")
    target_conf = File.read!("test/fixtures/with_encrypted_deltas.conf")

    assert {:error, [err]} =
             Confuse.Fwup.validate_delta(source_conf, target_conf, Version.parse!("1.0.0"))

    assert err =~
             "Delta firmware update requires fwup version"
  end

  test "validate delta, unlikely raw deltas" do
    source_conf = File.read!("test/fixtures/no_raw_writes.conf")
    target_conf = File.read!("test/fixtures/raw_deltas.conf")
    assert {:error, [err]} = Confuse.Fwup.validate_delta(source_conf, target_conf)

    assert err =~ "Target uses raw deltas but source has no raw writes"
  end

  test "validate delta, unlikely FAT deltas" do
    source_conf = File.read!("test/fixtures/no_fat_writes.conf")
    target_conf = File.read!("test/fixtures/fat_deltas.conf")
    assert {:error, [err]} = Confuse.Fwup.validate_delta(source_conf, target_conf)

    assert err =~ "Target uses FAT deltas but source has no FAT writes"
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

  test "get upgrade task files from rpi4 config" do
    expected_files =
      ~w(
        bcm2711-rpi-4-b.dtb
        bcm2711-rpi-400.dtb
        bcm2711-rpi-cm4.dtb
        cmdline.txt
        config.txt
        dwc2.dtbo
        fixup4.dat
        i2c-mux.dtbo
        imx219.dtbo
        imx296.dtbo
        imx477.dtbo
        imx708.dtbo
        kernel8.img
        miniuart-bt.dtbo
        ov5647.dtbo
        overlay_map.dtb
        pwm-2chan.dtbo
        pwm.dtbo
        pwm1.dtbo
        ramoops.dtbo
        rootfs.img
        rpi-backlight.dtbo
        rpi-ft5406.dtbo
        start4.elf
        tc358743.dtbo
        vc4-kms-dsi-7inch.dtbo
        vc4-kms-dsi-ili9881-7inch.dtbo
        vc4-kms-v3d-pi4.dtbo
        vc4-kms-v3d.dtbo
        w1-gpio-pullup.dtbo
      )

    assert {:ok, ^expected_files} =
             Confuse.Fwup.get_upgrade_task_files("test/fixtures/rpi4-fwup.conf")
  end

  test "get upgrade task files from config string" do
    conf = File.read!("test/fixtures/rpi4-fwup.conf")
    assert {:ok, files} = Confuse.Fwup.get_upgrade_tasks_files_from_config(conf)
    assert "rootfs.img" in files
    assert "config.txt" in files
    assert length(files) == 30
  end

  test "get upgrade task files from config with no upgrade tasks" do
    assert {:ok, []} = Confuse.Fwup.get_upgrade_tasks_files_from_config("")
  end

  test "get upgrade task files excludes non-upgrade tasks" do
    conf = """
    task complete {
      on-resource kernel8.img {
        fat_write(10, "kernel8.img")
      }
      on-resource config.txt {
        fat_write(10, "config.txt")
      }
      on-resource rootfs.img {
        raw_write(0)
      }
      on-resource extra-boot.bin {
        fat_write(10, "extra-boot.bin")
      }
    }
    task upgrade.a {
      on-resource config.txt {
        fat_write(10, "config.txt")
      }
      on-resource rootfs.img {
        raw_write(100)
      }
    }
    task provision {
      on-resource provision-data.img {
        raw_write(200)
      }
      on-resource provision-key.bin {
        raw_write(300)
      }
    }
    """

    assert {:ok, ["config.txt", "rootfs.img"]} =
             Confuse.Fwup.get_upgrade_tasks_files_from_config(conf)
  end

  test "get upgrade task files deduplicates across upgrade.a and upgrade.b" do
    conf = """
    task upgrade.a {
      on-resource rootfs.img {
        raw_write(100)
      }
      on-resource config.txt {
        fat_write(50, "config.txt")
      }
    }
    task upgrade.b {
      on-resource rootfs.img {
        raw_write(200)
      }
      on-resource config.txt {
        fat_write(60, "config.txt")
      }
    }
    """

    assert {:ok, ["config.txt", "rootfs.img"]} =
             Confuse.Fwup.get_upgrade_tasks_files_from_config(conf)
  end

  @tag :tmp_dir
  test "fail to load upgrade task files", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "nonexistent.conf")
    assert {:error, :enoent} = Confuse.Fwup.get_upgrade_task_files(path)
  end

  @tag :tmp_dir
  test "fail to load file", %{tmp_dir: tmp_dir} do
    path = Path.join(tmp_dir, "foo.conf")
    assert {:error, :enoent} = Confuse.Fwup.get_delta_files(path)
  end
end
