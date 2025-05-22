%{
  {:function, "include"} => [~c"${NERVES_SDK_IMAGES:-.}/fwup_include/rpi4-common.conf"],
  {"file-resource", "bcm2711-rpi-4-b.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/bcm2711-rpi-4-b.dtb"
  },
  {"file-resource", "bcm2711-rpi-400.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/bcm2711-rpi-400.dtb"
  },
  {"file-resource", "bcm2711-rpi-cm4.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/bcm2711-rpi-cm4.dtb"
  },
  {"file-resource", "cmdline.txt"} => %{"host-path" => "${NERVES_SYSTEM}/images/cmdline.txt"},
  {"file-resource", "config.txt"} => %{"host-path" => "${NERVES_SYSTEM}/images/config.txt"},
  {"file-resource", "dwc2.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/dwc2.dtbo"
  },
  {"file-resource", "fixup4.dat"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/fixup4x.dat"
  },
  {"file-resource", "i2c-mux.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/i2c-mux.dtbo"
  },
  {"file-resource", "imx219.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx219.dtbo"
  },
  {"file-resource", "imx296.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx296.dtbo"
  },
  {"file-resource", "imx477.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx477.dtbo"
  },
  {"file-resource", "imx708.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx708.dtbo"
  },
  {"file-resource", "kernel8.img"} => %{"host-path" => "${NERVES_SYSTEM}/images/Image"},
  {"file-resource", "miniuart-bt.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/miniuart-bt.dtbo"
  },
  {"file-resource", "ov5647.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/ov5647.dtbo"
  },
  {"file-resource", "overlay_map.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/overlay_map.dtb"
  },
  {"file-resource", "pwm-2chan.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/pwm-2chan.dtbo"
  },
  {"file-resource", "pwm.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/pwm.dtbo"
  },
  {"file-resource", "pwm1.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/pwm1.dtbo"
  },
  {"file-resource", "ramoops.dtbo"} => %{"host-path" => "${NERVES_SYSTEM}/images/ramoops.dtb"},
  {"file-resource", "rpi-backlight.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/rpi-backlight.dtbo"
  },
  {"file-resource", "rpi-ft5406.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/rpi-ft5406.dtbo"
  },
  {"file-resource", "start4.elf"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/start4x.elf"
  },
  {"file-resource", "tc358743.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/tc358743.dtbo"
  },
  {"file-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-dsi-7inch.dtbo"
  },
  {"file-resource", "vc4-kms-dsi-ili9881-7inch.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-dsi-ili9881-7inch.dtbo"
  },
  {"file-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-v3d-pi4.dtbo"
  },
  {"file-resource", "vc4-kms-v3d.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-v3d.dtbo"
  },
  {"file-resource", "w1-gpio-pullup.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/w1-gpio-pullup.dtbo"
  },
  "require-fwup-version" => "0.15.0"
}
