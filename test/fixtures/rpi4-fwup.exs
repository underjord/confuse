%{
  {"mbr", "mbr-a"} => %{
    {"partition", "0"} => %{
      "block-count" => "${BOOT_A_PART_COUNT}",
      "block-offset" => "${BOOT_A_PART_OFFSET}",
      "boot" => "true",
      "type" => "0xc"
    },
    {"partition", "1"} => %{
      "block-count" => "${ROOTFS_A_PART_COUNT}",
      "block-offset" => "${ROOTFS_A_PART_OFFSET}",
      "type" => "0x83"
    },
    {"partition", "2"} => %{
      "block-count" => "${APP_PART_COUNT}",
      "block-offset" => "${APP_PART_OFFSET}",
      "expand" => "true",
      "type" => "0x83"
    }
  },
  {"file-resource", "imx477.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx477.dtbo"
  },
  {"file-resource", "ov5647.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/ov5647.dtbo"
  },
  {"file-resource", "miniuart-bt.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/miniuart-bt.dtbo"
  },
  {"file-resource", "pwm-2chan.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/pwm-2chan.dtbo"
  },
  {"file-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-v3d-pi4.dtbo"
  },
  {"file-resource", "kernel8.img"} => %{"host-path" => "${NERVES_SYSTEM}/images/Image"},
  {"file-resource", "overlay_map.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/overlay_map.dtb"
  },
  {"file-resource", "w1-gpio-pullup.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/w1-gpio-pullup.dtbo"
  },
  {"task", "provision.wrongplatform"} => %{
    {"on-init", ""} => %{
      {:function, "error"} =>
        ~c"Expecting platform=${NERVES_FW_PLATFORM} and architecture=${NERVES_FW_ARCHITECTURE}"
    }
  },
  {"file-resource", "bcm2711-rpi-400.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/bcm2711-rpi-400.dtb"
  },
  {"uboot-environment", "uboot-env"} => %{
    "block-count" => "${UBOOT_ENV_COUNT}",
    "block-offset" => "${UBOOT_ENV_OFFSET}"
  },
  {"file-resource", "dwc2.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/dwc2.dtbo"
  },
  {"file-resource", "rpi-ft5406.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/rpi-ft5406.dtbo"
  },
  {:function, "include"} => ~c"${NERVES_SDK_IMAGES:-.}/fwup_include/rpi4-common.conf",
  {"file-resource", "bcm2711-rpi-cm4.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/bcm2711-rpi-cm4.dtb"
  },
  {"file-resource", "i2c-mux.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/i2c-mux.dtbo"
  },
  {"file-resource", "bcm2711-rpi-4-b.dtb"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/bcm2711-rpi-4-b.dtb"
  },
  {"file-resource", "ramoops.dtbo"} => %{"host-path" => "${NERVES_SYSTEM}/images/ramoops.dtb"},
  "require-fwup-version" => "0.15.0",
  {"file-resource", "imx219.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx219.dtbo"
  },
  {"task", "upgrade.wrongplatform"} => %{
    {"on-init", ""} => %{
      {:function, "error"} =>
        ~c"Expecting platform=${NERVES_FW_PLATFORM} and architecture=${NERVES_FW_ARCHITECTURE}"
    }
  },
  {"file-resource", "cmdline.txt"} => %{"host-path" => "${NERVES_SYSTEM}/images/cmdline.txt"},
  {"file-resource", "tc358743.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/tc358743.dtbo"
  },
  {"task", "upgrade.unexpected"} => %{
    {:function, "require-uboot-variable"} =>
      ~c"uboot-enva.nerves_fw_architecture${NERVES_FW_ARCHITECTURE}",
    {"on-init", ""} => %{
      {:function, "error"} =>
        ~c"Please check the media being upgraded. It doesn't look like either the A or B partitions are active."
    }
  },
  {"file-resource", "imx708.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx708.dtbo"
  },
  {"mbr", "mbr-b"} => %{
    {"partition", "0"} => %{
      "block-count" => "${BOOT_B_PART_COUNT}",
      "block-offset" => "${BOOT_B_PART_OFFSET}",
      "boot" => "true",
      "type" => "0xc"
    },
    {"partition", "1"} => %{
      "block-count" => "${ROOTFS_B_PART_COUNT}",
      "block-offset" => "${ROOTFS_B_PART_OFFSET}",
      "type" => "0x83"
    },
    {"partition", "2"} => %{
      "block-count" => "${APP_PART_COUNT}",
      "block-offset" => "${APP_PART_OFFSET}",
      "expand" => "true",
      "type" => "0x83"
    }
  },
  {"task", "provision"} => %{
    {:function, "require-uboot-variable"} =>
      ~c"uboot-enva.nerves_fw_architecture${NERVES_FW_ARCHITECTURE}",
    {"on-init", ""} => %{{:function, "include"} => ~c"${NERVES_PROVISIONING}"}
  },
  {"file-resource", "start4.elf"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/start4x.elf"
  },
  {"file-resource", "fixup4.dat"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/fixup4x.dat"
  },
  {"file-resource", "vc4-kms-v3d.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-v3d.dtbo"
  },
  {"file-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-dsi-7inch.dtbo"
  },
  {"file-resource", "rootfs.img"} => %{
    "assert-size-lte" => "${ROOTFS_A_PART_COUNT}",
    "host-path" => "${ROOTFS}"
  },
  {"file-resource", "rpi-backlight.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/rpi-backlight.dtbo"
  },
  {"file-resource", "pwm1.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/pwm1.dtbo"
  },
  {"file-resource", "config.txt"} => %{"host-path" => "${NERVES_SYSTEM}/images/config.txt"},
  {"file-resource", "vc4-kms-dsi-ili9881-7inch.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/vc4-kms-dsi-ili9881-7inch.dtbo"
  },
  {"file-resource", "imx296.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/imx296.dtbo"
  },
  {"task", "upgrade.a"} => %{
    {"on-resource", "overlay_map.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/overlay_map.dtb"
    },
    {"on-resource", "tc358743.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/tc358743.dtbo"
    },
    {"on-resource", "pwm-2chan.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/pwm-2chan.dtbo"
    },
    {"on-resource", "cmdline.txt"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}cmdline.txt"
    },
    {"on-resource", "imx219.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx219.dtbo"
    },
    {"on-resource", "w1-gpio-pullup.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/w1-gpio-pullup.dtbo"
    },
    {"on-resource", "i2c-mux.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/i2c-mux.dtbo"
    },
    {"on-resource", "kernel8.img"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}kernel8.img"
    },
    {"on-resource", "pwm.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/pwm.dtbo"
    },
    {"on-resource", "pwm1.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/pwm1.dtbo"
    },
    {"on-resource", "imx296.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx296.dtbo"
    },
    {"on-resource", "config.txt"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}config.txt"
    },
    {"on-resource", "bcm2711-rpi-cm4.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}bcm2711-rpi-cm4.dtb"
    },
    {"on-resource", "rootfs.img"} => %{
      {:function, "raw_write"} => ~c"${ROOTFS_A_PART_OFFSET}",
      "delta-source-raw-count" => "${ROOTFS_B_PART_COUNT}",
      "delta-source-raw-offset" => "${ROOTFS_B_PART_OFFSET}"
    },
    {:function, "require-uboot-variable"} =>
      ~c"uboot-envb.nerves_fw_architecture${NERVES_FW_ARCHITECTURE}",
    {"on-resource", "rpi-backlight.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/rpi-backlight.dtbo"
    },
    {"on-resource", "fixup4.dat"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}fixup4.dat"
    },
    {"on-resource", "bcm2711-rpi-400.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}bcm2711-rpi-400.dtb"
    },
    {"on-resource", "vc4-kms-dsi-ili9881-7inch.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-dsi-ili9881-7inch.dtbo"
    },
    {"on-resource", "imx477.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx477.dtbo"
    },
    {"on-resource", "rpi-ft5406.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/rpi-ft5406.dtbo"
    },
    {"on-resource", "miniuart-bt.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/miniuart-bt.dtbo"
    },
    {"on-error", ""} => %{},
    {:function, "require-partition-offset"} => [
      1,
      36,
      123,
      82,
      79,
      79,
      84,
      70,
      83,
      95,
      66,
      95,
      80,
      65,
      82,
      84,
      95,
      79,
      70,
      70,
      83,
      69,
      84,
      125
    ],
    {"on-resource", "imx708.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx708.dtbo"
    },
    {"on-resource", "dwc2.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/dwc2.dtbo"
    },
    {"on-resource", "start4.elf"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}start4.elf"
    },
    {"on-resource", "ov5647.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/ov5647.dtbo"
    },
    {"on-finish", ""} => %{
      {:function, "mbr_write"} => ~c"mbr-a",
      {:function, "uboot_setenv"} => ~c"uboot-envnerves_fw_activea"
    },
    {"on-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-dsi-7inch.dtbo"
    },
    {"on-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-v3d-pi4.dtbo"
    },
    {"on-resource", "vc4-kms-v3d.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-v3d.dtbo"
    },
    {"on-init", ""} => %{
      {:function, "fat_mkdir"} => ~c"${BOOT_A_PART_OFFSET}overlays",
      {:function, "fat_mkfs"} => ~c"${BOOT_A_PART_OFFSET}${BOOT_A_PART_COUNT}",
      {:function, "fat_setlabel"} => ~c"${BOOT_A_PART_OFFSET}BOOT-A",
      {:function, "info"} => ~c"Upgrading partition A",
      {:function, "trim"} => ~c"${ROOTFS_A_PART_OFFSET}${ROOTFS_A_PART_COUNT}",
      {:function, "uboot_unsetenv"} => ~c"uboot-enva.nerves_fw_uuid"
    },
    {"on-resource", "bcm2711-rpi-4-b.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}bcm2711-rpi-4-b.dtb"
    },
    {"on-resource", "ramoops.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/ramoops.dtbo"
    }
  },
  {"task", "upgrade.b"} => %{
    {"on-resource", "overlay_map.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/overlay_map.dtb"
    },
    {"on-resource", "tc358743.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/tc358743.dtbo"
    },
    {"on-resource", "pwm-2chan.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/pwm-2chan.dtbo"
    },
    {"on-resource", "cmdline.txt"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}cmdline.txt"
    },
    {"on-resource", "imx219.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/imx219.dtbo"
    },
    {"on-resource", "w1-gpio-pullup.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/w1-gpio-pullup.dtbo"
    },
    {"on-resource", "i2c-mux.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/i2c-mux.dtbo"
    },
    {"on-resource", "kernel8.img"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}kernel8.img"
    },
    {"on-resource", "pwm.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/pwm.dtbo"
    },
    {"on-resource", "pwm1.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/pwm1.dtbo"
    },
    {"on-resource", "imx296.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/imx296.dtbo"
    },
    {"on-resource", "config.txt"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}config.txt"
    },
    {"on-resource", "bcm2711-rpi-cm4.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}bcm2711-rpi-cm4.dtb"
    },
    {"on-resource", "rootfs.img"} => %{
      {:function, "raw_write"} => ~c"${ROOTFS_B_PART_OFFSET}",
      "delta-source-raw-count" => "${ROOTFS_A_PART_COUNT}",
      "delta-source-raw-offset" => "${ROOTFS_A_PART_OFFSET}"
    },
    {:function, "require-uboot-variable"} =>
      ~c"uboot-enva.nerves_fw_architecture${NERVES_FW_ARCHITECTURE}",
    {"on-resource", "rpi-backlight.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/rpi-backlight.dtbo"
    },
    {"on-resource", "fixup4.dat"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}fixup4.dat"
    },
    {"on-resource", "bcm2711-rpi-400.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}bcm2711-rpi-400.dtb"
    },
    {"on-resource", "vc4-kms-dsi-ili9881-7inch.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/vc4-kms-dsi-ili9881-7inch.dtbo"
    },
    {"on-resource", "imx477.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/imx477.dtbo"
    },
    {"on-resource", "rpi-ft5406.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/rpi-ft5406.dtbo"
    },
    {"on-resource", "miniuart-bt.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/miniuart-bt.dtbo"
    },
    {"on-error", ""} => %{},
    {:function, "require-partition-offset"} => [
      1,
      36,
      123,
      82,
      79,
      79,
      84,
      70,
      83,
      95,
      65,
      95,
      80,
      65,
      82,
      84,
      95,
      79,
      70,
      70,
      83,
      69,
      84,
      125
    ],
    {"on-resource", "imx708.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/imx708.dtbo"
    },
    {"on-resource", "dwc2.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/dwc2.dtbo"
    },
    {"on-resource", "start4.elf"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}start4.elf"
    },
    {"on-resource", "ov5647.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/ov5647.dtbo"
    },
    {"on-finish", ""} => %{
      {:function, "mbr_write"} => ~c"mbr-b",
      {:function, "uboot_setenv"} => ~c"uboot-envnerves_fw_activeb"
    },
    {"on-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/vc4-kms-dsi-7inch.dtbo"
    },
    {"on-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/vc4-kms-v3d-pi4.dtbo"
    },
    {"on-resource", "vc4-kms-v3d.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/vc4-kms-v3d.dtbo"
    },
    {"on-init", ""} => %{
      {:function, "fat_mkdir"} => ~c"${BOOT_B_PART_OFFSET}overlays",
      {:function, "fat_mkfs"} => ~c"${BOOT_B_PART_OFFSET}${BOOT_B_PART_COUNT}",
      {:function, "fat_setlabel"} => ~c"${BOOT_B_PART_OFFSET}BOOT-B",
      {:function, "info"} => ~c"Upgrading partition B",
      {:function, "trim"} => ~c"${ROOTFS_B_PART_OFFSET}${ROOTFS_B_PART_COUNT}",
      {:function, "uboot_unsetenv"} => ~c"uboot-envb.nerves_fw_uuid"
    },
    {"on-resource", "bcm2711-rpi-4-b.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}bcm2711-rpi-4-b.dtb"
    },
    {"on-resource", "ramoops.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_B_PART_OFFSET}overlays/ramoops.dtbo"
    }
  },
  {"task", "complete"} => %{
    {"on-resource", "overlay_map.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/overlay_map.dtb"
    },
    {"on-resource", "tc358743.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/tc358743.dtbo"
    },
    {"on-resource", "pwm-2chan.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/pwm-2chan.dtbo"
    },
    {"on-resource", "cmdline.txt"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}cmdline.txt"
    },
    {"on-resource", "imx219.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx219.dtbo"
    },
    {"on-resource", "w1-gpio-pullup.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/w1-gpio-pullup.dtbo"
    },
    {"on-resource", "i2c-mux.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/i2c-mux.dtbo"
    },
    {"on-resource", "kernel8.img"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}kernel8.img"
    },
    {"on-resource", "pwm.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/pwm.dtbo"
    },
    {"on-resource", "pwm1.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/pwm1.dtbo"
    },
    {"on-resource", "imx296.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx296.dtbo"
    },
    {"on-resource", "config.txt"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}config.txt"
    },
    {"on-resource", "bcm2711-rpi-cm4.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}bcm2711-rpi-cm4.dtb"
    },
    {"on-resource", "rootfs.img"} => %{{:function, "raw_write"} => ~c"${ROOTFS_A_PART_OFFSET}"},
    {"on-resource", "rpi-backlight.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/rpi-backlight.dtbo"
    },
    {"on-resource", "fixup4.dat"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}fixup4.dat"
    },
    {"on-resource", "bcm2711-rpi-400.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}bcm2711-rpi-400.dtb"
    },
    {"on-resource", "vc4-kms-dsi-ili9881-7inch.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-dsi-ili9881-7inch.dtbo"
    },
    {"on-resource", "imx477.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx477.dtbo"
    },
    {"on-resource", "rpi-ft5406.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/rpi-ft5406.dtbo"
    },
    {"on-resource", "miniuart-bt.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/miniuart-bt.dtbo"
    },
    {"on-resource", "imx708.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/imx708.dtbo"
    },
    "require-unmounted-destination" => "true",
    {"on-resource", "dwc2.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/dwc2.dtbo"
    },
    {"on-resource", "start4.elf"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}start4.elf"
    },
    {"on-resource", "ov5647.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/ov5647.dtbo"
    },
    {"on-finish", ""} => %{
      {:function, "raw_memset"} => [
        36,
        123,
        65,
        80,
        80,
        95,
        80,
        65,
        82,
        84,
        95,
        79,
        70,
        70,
        83,
        69,
        84,
        125,
        256,
        48,
        120,
        102,
        102
      ]
    },
    {"on-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-dsi-7inch.dtbo"
    },
    {"on-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-v3d-pi4.dtbo"
    },
    {"on-resource", "vc4-kms-v3d.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/vc4-kms-v3d.dtbo"
    },
    {"on-init", ""} => %{
      {:function, "fat_mkdir"} => ~c"${BOOT_A_PART_OFFSET}overlays",
      {:function, "fat_mkfs"} => ~c"${BOOT_A_PART_OFFSET}${BOOT_A_PART_COUNT}",
      {:function, "fat_setlabel"} => ~c"${BOOT_A_PART_OFFSET}BOOT-A",
      {:function, "include"} => ~c"${NERVES_PROVISIONING}",
      {:function, "mbr_write"} => ~c"mbr-a",
      {:function, "uboot_clearenv"} => ~c"uboot-env",
      {:function, "uboot_setenv"} => ~c"uboot-enva.nerves_fw_uuid\\${FWUP_META_UUID}"
    },
    {"on-resource", "bcm2711-rpi-4-b.dtb"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}bcm2711-rpi-4-b.dtb"
    },
    {"on-resource", "ramoops.dtbo"} => %{
      {:function, "fat_write"} => ~c"${BOOT_A_PART_OFFSET}overlays/ramoops.dtbo"
    }
  },
  {"file-resource", "pwm.dtbo"} => %{
    "host-path" => "${NERVES_SYSTEM}/images/rpi-firmware/overlays/pwm.dtbo"
  }
}
