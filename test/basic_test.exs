defmodule Confuse.BasicTest do
  use ExUnit.Case

  alias Helpers

  defmodule B do
    import NimbleParsec
    defparsec(:key_char, Confuse.Helpers.key_char())
    defparsec(:block, Confuse.Helpers.block())
  end

  test "valid key characters" do
    assert {:ok, ~c"azAZ09-_.", "", %{}, {1, 0}, 9} =
             "azAZ09-_."
             |> B.key_char()
  end

  test "split at invalid key characters" do
    assert {:ok, ~c"azAZ09", "+-_.", %{}, {1, 0}, 6} =
             "azAZ09+-_."
             |> B.key_char()
  end

  test "empty block with label" do
    assert {:ok, [{:block, [tag: ~c"thing", label: ~c"foo", body: []]}], "", %{}, {3, 15}, 16} =
             """
             thing "foo" {

             }
             """
             |> String.trim()
             |> B.block()
  end

  test "nested empty block with label" do
    assert {:ok,
            [
              {:block,
               [
                 tag: ~c"thing",
                 label: ~c"foo",
                 body: [{:block, [tag: ~c"thing", label: ~c"bar", body: []]}]
               ]}
            ], "", %{}, {5, 35},
            36} =
             """
             thing "foo" {
               thing "bar" {

               }
             }
             """
             |> String.trim()
             |> B.block()
  end

  test "troubled block" do
    assert {:ok,
            [
              {:block,
               [
                 tag: ~c"thing",
                 label: ~c"foo",
                 body: [{:block, [tag: ~c"thing", label: ~c"bar", body: []]}]
               ]}
            ], "", %{}, {5, 35},
            36} =
             """
             task "complete" {
             on-init {
             funlist={2,uboot_clearenv,"uboot-env",4,uboot_setenv,"uboot-env",nerves_fw_devpath,"/dev/mmcblk0",4,uboot_setenv,"uboot-env",b.nerves_fw_application_part0_devpath,"/dev/mmcblk0p9",4,uboot_setenv,"uboot-env",b.nerves_fw_application_part0_fstype,f2fs,4,uboot_setenv,"uboot-env",b.nerves_fw_application_part0_target,"/root",4,uboot_setenv,"uboot-env",b.nerves_fw_product,routines_os,4,uboot_setenv,"uboot-env",b.nerves_fw_description,"Waffle W1 Nerves System",4,uboot_setenv,"uboot-env",b.nerves_fw_version,"0.0.0-alpha.0",4,uboot_setenv,"uboot-env",b.nerves_fw_platform,Waffle,4,uboot_setenv,"uboot-env",b.nerves_fw_architecture,arm,4,uboot_setenv,"uboot-env",b.nerves_fw_author,"Eliel A. Gordon",4,uboot_setenv,"uboot-env",b.nerves_fw_vcs_identifier,"",4,uboot_setenv,"uboot-env",b.nerves_fw_misc,"",4,uboot_setenv,"uboot-env",b.nerves_fw_uuid,"${FWUP_META_UUID}",2,execute,"bootenv -s /dev/mmcblk0p3 /kernel_meta partition kernel-B",2,execute,"bootenv -s /dev/mmcblk0p3 /rootfs_meta partition rootfs-B",2,execute,"bootenv -s /dev/mmcblk0p3 / cmdline \"console=ttyS0 panic=1 earlycon loglevel=7 noinitrd root=/dev/mmcblk0p8 ro rootfstype=squashfs rootwait init=/sbin/init random.trust_cpu=on random.trust_bootloader=on\"",2,execute,"bootenv -s /dev/mmcblk0p3 / update_state U",4,uboot_setenv,"uboot-env",nerves_fw_active,b}
             }
             on-resource "kernel_dtb" {
             funlist={2,raw_write,16384}
             }
             on-resource "kernel_Image" {
             funlist={2,raw_write,53248}
             }
             on-resource "rootfs" {
             funlist={2,raw_write,1134592}
             }
             }
             """
             |> String.trim()
             |> B.block()
  end
end
