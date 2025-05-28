%{
  {"mbr", "mbr-a"} => %{
    {"partition", "0"} => %{
      "block-count" => 38_630,
      "block-offset" => "63",
      "boot" => "true",
      "type" => 12
    },
    {"partition", "1"} => %{"block-count" => 289_044, "block-offset" => "77324", "type" => 131},
    {"partition", "2"} => %{
      "block-count" => 1_048_576,
      "block-offset" => "655412",
      "expand" => "true",
      "type" => 131
    }
  },
  {"file-resource", "imx477.dtbo"} => %{
    "blake2b-256" => "133b77e11109a616fc8f72e9322645056c447df8a3844ade38e793906dc5c571",
    "length" => 3653
  },
  {"file-resource", "ov5647.dtbo"} => %{
    "blake2b-256" => "022b8335306a936975afd4cb1334996419459074eb59637fe74d360407f35fa6",
    "length" => 3443
  },
  {"file-resource", "miniuart-bt.dtbo"} => %{
    "blake2b-256" => "80260eb5a8c7aa92167e5cd10845d7d56232b83174adfed3c13bd44ae9118df2",
    "length" => 1566
  },
  {"file-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
    "blake2b-256" => "20607e128ea9653107073f252b3d4d8c4235746543ecc266e2ec4130ae3a6cdf",
    "length" => 3913
  },
  "meta-architecture" => "arm",
  "meta-author" => "The Nerves Team",
  {"file-resource", "kernel8.img"} => %{
    "blake2b-256" => "2f6104c5d4370d53648e3b42c3537b3fb47c9f0bbb12a8b526717cc373d93fe0",
    "length" => 11_849_736
  },
  {"file-resource", "overlay_map.dtb"} => %{
    "blake2b-256" => "d8e10d261f7cf81d5547d897b75565eaae7a3d2086bb0080e003785bb9ec72a6",
    "length" => 5255
  },
  {"file-resource", "w1-gpio-pullup.dtbo"} => %{
    "blake2b-256" => "a9b50989bc267f3af27da6c27036e17ca5322ae6582548b4f9d47e92ef502033",
    "length" => 1171
  },
  {"task", "provision.wrongplatform"} => %{
    {"on-init", ""} => %{
      "funlist" => ["2", "error", "Expecting platform=rpi4 and architecture=arm"]
    }
  },
  {"file-resource", "bcm2711-rpi-400.dtb"} => %{
    "blake2b-256" => "4ae37e4f6730bc6cfa92bdce9f163189a5ede659ec5519c6d46881dd92835a93",
    "length" => 55_808
  },
  {"uboot-environment", "uboot-env"} => %{"block-count" => 16, "block-offset" => 16},
  {"file-resource", "dwc2.dtbo"} => %{
    "blake2b-256" => "47af758aa9349673e5ee5374eaabbfe733a89f1662a8d76db5c4a09f1415db7d",
    "length" => 801
  },
  {"file-resource", "rpi-ft5406.dtbo"} => %{
    "blake2b-256" => "a89ae7ca0c298fdd4a08b7acdf217bfa712212dd69556774f94544e37daeb4f4",
    "length" => 842
  },
  "meta-product" => "berlin2024",
  {"file-resource", "bcm2711-rpi-cm4.dtb"} => %{
    "blake2b-256" => "9ae0a49730bf1baac3badf2fdb93b27febddb09da6f0c89e565ff0f85d26c9b3",
    "length" => 56_444
  },
  {"file-resource", "i2c-mux.dtbo"} => %{
    "blake2b-256" => "de32be2b79f54426898a3ed4e87e69e18e82149d19a249f83884c2646691b8fe",
    "length" => 3412
  },
  {"file-resource", "bcm2711-rpi-4-b.dtb"} => %{
    "blake2b-256" => "daf88361aaf76008c0009dba1586f07f429ca5d0266399c4cbe2963ec7961a60",
    "length" => 55_804
  },
  {"file-resource", "ramoops.dtbo"} => %{
    "blake2b-256" => "33e28d565a4440d942652af3d8d50b9bc3cf2e1615036f89352b1d09092e8abb",
    "length" => 521
  },
  "require-fwup-version" => "0.15.0",
  {"file-resource", "imx219.dtbo"} => %{
    "blake2b-256" => "0b478505750b99e35ed42d51b6d2a96b30f7a262ab82f52bbb2d76528238e7bb",
    "length" => 3307
  },
  {"task", "upgrade.wrongplatform"} => %{
    {"on-init", ""} => %{
      "funlist" => ["2", "error", "Expecting platform=rpi4 and architecture=arm"]
    }
  },
  {"file-resource", "cmdline.txt"} => %{
    "blake2b-256" => "99162bf9379f918e7a4096087f157f73af0f1f9c8c1781b8851272ad1990c2d4",
    "length" => 486
  },
  {"file-resource", "tc358743.dtbo"} => %{
    "blake2b-256" => "a3c824d5023810bcdab27c52ddd27e4db3f7e2c919045b231c21fa80fafefe2e",
    "length" => 2921
  },
  "meta-version" => "0.4.0",
  {"task", "upgrade.unexpected"} => %{
    {"on-init", ""} => %{
      "funlist" => [
        "2",
        "error",
        "Please check the media being upgraded. It doesn't look like either the A or B partitions are active."
      ]
    },
    "reqlist" => [
      "4",
      "require-uboot-variable",
      "uboot-env",
      "a.nerves_fw_platform",
      "rpi4",
      "4",
      "require-uboot-variable",
      "uboot-env",
      "a.nerves_fw_architecture",
      "arm"
    ]
  },
  {"file-resource", "imx708.dtbo"} => %{
    "blake2b-256" => "d711095dd1a584a27ae8908969bf5c5e5a811aff48a5d2fcde3fd2c243187de0",
    "length" => 3981
  },
  {"mbr", "mbr-b"} => %{
    {"partition", "0"} => %{
      "block-count" => 38630,
      "block-offset" => "38693",
      "boot" => "true",
      "type" => 12
    },
    {"partition", "1"} => %{"block-count" => 289_044, "block-offset" => "366368", "type" => 131},
    {"partition", "2"} => %{
      "block-count" => 1_048_576,
      "block-offset" => "655412",
      "expand" => "true",
      "type" => 131
    }
  },
  {"task", "provision"} => %{
    {"on-init", ""} => %{
      "funlist" => [
        "4",
        "uboot_setenv",
        "uboot-env",
        "wifi_ssid",
        "${NERVES_WIFI_SSID}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "wifi_passphrase",
        "${NERVES_WIFI_PASSPHRASE}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "wifi_force",
        "${NERVES_WIFI_FORCE}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "nerves_serial_number",
        "${NERVES_SERIAL_NUMBER}"
      ]
    },
    "reqlist" => [
      "4",
      "require-uboot-variable",
      "uboot-env",
      "a.nerves_fw_platform",
      "rpi4",
      "4",
      "require-uboot-variable",
      "uboot-env",
      "a.nerves_fw_architecture",
      "arm"
    ]
  },
  {"file-resource", "start4.elf"} => %{
    "blake2b-256" => "d35c607d434157b7d28ebf6e47b6014038d099d1ae46bf508cf5dab2558794c4",
    "length" => 3_004_808
  },
  {"file-resource", "fixup4.dat"} => %{
    "blake2b-256" => "dc44189cfea48c6b6679ec2c26fc6cbcd783e21dbd017ab3718e9cddf103f959",
    "length" => 8425
  },
  {"file-resource", "vc4-kms-v3d.dtbo"} => %{
    "blake2b-256" => "7a65f9fe751620fbe29bac4f4e470b2bdd756a65d694df9c6b90ccb522947494",
    "length" => 2760
  },
  {"file-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
    "blake2b-256" => "0b7484a8343910d43c7c5cc5fd372045e3fba331023146446eb698da5e64998d",
    "length" => 4336
  },
  {"file-resource", "rootfs.img"} => %{
    "blake2b-256" => "e9cfeeaa129b632d169cd9da0cc0a91273a2db7f2a5130a01b69c49bd46d3c56",
    "length" => 117_010_432
  },
  "meta-platform" => "rpi4",
  {"file-resource", "rpi-backlight.dtbo"} => %{
    "blake2b-256" => "6fdcce37dee30c504580c31e14aa535809e7be94a49c28512bff6fc6e9fddffb",
    "length" => 489
  },
  {"file-resource", "config.txt"} => %{
    "blake2b-256" => "5015d3a03bf25adf978919f8859742616ba79fbd301170b9d7f978241d00ff61",
    "length" => 1937
  },
  {"file-resource", "imx296.dtbo"} => %{
    "blake2b-256" => "71f782e4ba64d2615f3d2d5959b6dc24fe46f132a0581ea37dced77a4fc384f1",
    "length" => 3566
  },
  {"task", "upgrade.a"} => %{
    {"on-finish", ""} => %{
      "funlist" => [
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_application_part0_devpath",
        "/dev/mmcblk0p3",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_application_part0_fstype",
        "f2fs",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_application_part0_target",
        "/root",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_product",
        "berlin2024",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_description",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_version",
        "0.4.0",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_platform",
        "rpi4",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_architecture",
        "arm",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_author",
        "The Nerves Team",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_vcs_identifier",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_misc",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_uuid",
        "${FWUP_META_UUID}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "nerves_fw_active",
        "a",
        "2",
        "mbr_write",
        "mbr-a"
      ]
    },
    {"on-init", ""} => %{
      "funlist" => [
        "2",
        "info",
        "Upgrading partition A",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "a.nerves_fw_version",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "a.nerves_fw_platform",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "a.nerves_fw_architecture",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "a.nerves_fw_uuid",
        "3",
        "fat_mkfs",
        "63",
        "38630",
        "3",
        "fat_setlabel",
        "63",
        "BOOT-A",
        "3",
        "fat_mkdir",
        "63",
        "overlays",
        "3",
        "trim",
        "77324",
        "289044"
      ]
    },
    {"on-resource", "bcm2711-rpi-4-b.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "bcm2711-rpi-4-b.dtb"]
    },
    {"on-resource", "bcm2711-rpi-400.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "bcm2711-rpi-400.dtb"]
    },
    {"on-resource", "bcm2711-rpi-cm4.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "bcm2711-rpi-cm4.dtb"]
    },
    {"on-resource", "cmdline.txt"} => %{"funlist" => ["3", "fat_write", "63", "cmdline.txt"]},
    {"on-resource", "config.txt"} => %{"funlist" => ["3", "fat_write", "63", "config.txt"]},
    {"on-resource", "dwc2.dtbo"} => %{"funlist" => ["3", "fat_write", "63", "overlays/dwc2.dtbo"]},
    {"on-resource", "fixup4.dat"} => %{"funlist" => ["3", "fat_write", "63", "fixup4.dat"]},
    {"on-resource", "i2c-mux.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/i2c-mux.dtbo"]
    },
    {"on-resource", "imx219.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx219.dtbo"]
    },
    {"on-resource", "imx296.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx296.dtbo"]
    },
    {"on-resource", "imx477.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx477.dtbo"]
    },
    {"on-resource", "imx708.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx708.dtbo"]
    },
    {"on-resource", "kernel8.img"} => %{"funlist" => ["3", "fat_write", "63", "kernel8.img"]},
    {"on-resource", "miniuart-bt.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/miniuart-bt.dtbo"]
    },
    {"on-resource", "ov5647.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/ov5647.dtbo"]
    },
    {"on-resource", "overlay_map.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/overlay_map.dtb"]
    },
    {"on-resource", "ramoops.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/ramoops.dtbo"]
    },
    {"on-resource", "rootfs.img"} => %{
      "delta-source-raw-count" => 289_044,
      "delta-source-raw-offset" => "366368",
      "funlist" => ["2", "raw_write", "77324"]
    },
    {"on-resource", "rpi-backlight.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/rpi-backlight.dtbo"]
    },
    {"on-resource", "rpi-ft5406.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/rpi-ft5406.dtbo"]
    },
    {"on-resource", "start4.elf"} => %{"funlist" => ["3", "fat_write", "63", "start4.elf"]},
    {"on-resource", "tc358743.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/tc358743.dtbo"]
    },
    {"on-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/vc4-kms-dsi-7inch.dtbo"]
    },
    {"on-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/vc4-kms-v3d-pi4.dtbo"]
    },
    {"on-resource", "vc4-kms-v3d.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/vc4-kms-v3d.dtbo"]
    },
    {"on-resource", "w1-gpio-pullup.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/w1-gpio-pullup.dtbo"]
    },
    "reqlist" => [
      "3",
      "require-partition-offset",
      "1",
      "366368",
      "4",
      "require-uboot-variable",
      "uboot-env",
      "b.nerves_fw_platform",
      "rpi4",
      "4",
      "require-uboot-variable",
      "uboot-env",
      "b.nerves_fw_architecture",
      "arm"
    ]
  },
  {"task", "upgrade.b"} => %{
    {"on-finish", ""} => %{
      "funlist" => [
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_application_part0_devpath",
        "/dev/mmcblk0p3",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_application_part0_fstype",
        "f2fs",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_application_part0_target",
        "/root",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_product",
        "berlin2024",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_description",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_version",
        "0.4.0",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_platform",
        "rpi4",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_architecture",
        "arm",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_author",
        "The Nerves Team",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_vcs_identifier",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_misc",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "b.nerves_fw_uuid",
        "${FWUP_META_UUID}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "nerves_fw_active",
        "b",
        "2",
        "mbr_write",
        "mbr-b"
      ]
    },
    {"on-init", ""} => %{
      "funlist" => [
        "2",
        "info",
        "Upgrading partition B",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "b.nerves_fw_version",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "b.nerves_fw_platform",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "b.nerves_fw_architecture",
        "3",
        "uboot_unsetenv",
        "uboot-env",
        "b.nerves_fw_uuid",
        "3",
        "fat_mkfs",
        "38693",
        "38630",
        "3",
        "fat_setlabel",
        "38693",
        "BOOT-B",
        "3",
        "fat_mkdir",
        "38693",
        "overlays",
        "3",
        "trim",
        "366368",
        "289044"
      ]
    },
    {"on-resource", "bcm2711-rpi-4-b.dtb"} => %{
      "funlist" => ["3", "fat_write", "38693", "bcm2711-rpi-4-b.dtb"]
    },
    {"on-resource", "bcm2711-rpi-400.dtb"} => %{
      "funlist" => ["3", "fat_write", "38693", "bcm2711-rpi-400.dtb"]
    },
    {"on-resource", "bcm2711-rpi-cm4.dtb"} => %{
      "funlist" => ["3", "fat_write", "38693", "bcm2711-rpi-cm4.dtb"]
    },
    {"on-resource", "cmdline.txt"} => %{"funlist" => ["3", "fat_write", "38693", "cmdline.txt"]},
    {"on-resource", "config.txt"} => %{"funlist" => ["3", "fat_write", "38693", "config.txt"]},
    {"on-resource", "dwc2.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/dwc2.dtbo"]
    },
    {"on-resource", "fixup4.dat"} => %{"funlist" => ["3", "fat_write", "38693", "fixup4.dat"]},
    {"on-resource", "i2c-mux.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/i2c-mux.dtbo"]
    },
    {"on-resource", "imx219.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/imx219.dtbo"]
    },
    {"on-resource", "imx296.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/imx296.dtbo"]
    },
    {"on-resource", "imx477.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/imx477.dtbo"]
    },
    {"on-resource", "imx708.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/imx708.dtbo"]
    },
    {"on-resource", "kernel8.img"} => %{"funlist" => ["3", "fat_write", "38693", "kernel8.img"]},
    {"on-resource", "miniuart-bt.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/miniuart-bt.dtbo"]
    },
    {"on-resource", "ov5647.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/ov5647.dtbo"]
    },
    {"on-resource", "overlay_map.dtb"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/overlay_map.dtb"]
    },
    {"on-resource", "ramoops.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/ramoops.dtbo"]
    },
    {"on-resource", "rootfs.img"} => %{
      "delta-source-raw-count" => 289_044,
      "delta-source-raw-offset" => "77324",
      "funlist" => ["2", "raw_write", "366368"]
    },
    {"on-resource", "rpi-backlight.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/rpi-backlight.dtbo"]
    },
    {"on-resource", "rpi-ft5406.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/rpi-ft5406.dtbo"]
    },
    {"on-resource", "start4.elf"} => %{"funlist" => ["3", "fat_write", "38693", "start4.elf"]},
    {"on-resource", "tc358743.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/tc358743.dtbo"]
    },
    {"on-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/vc4-kms-dsi-7inch.dtbo"]
    },
    {"on-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/vc4-kms-v3d-pi4.dtbo"]
    },
    {"on-resource", "vc4-kms-v3d.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/vc4-kms-v3d.dtbo"]
    },
    {"on-resource", "w1-gpio-pullup.dtbo"} => %{
      "funlist" => ["3", "fat_write", "38693", "overlays/w1-gpio-pullup.dtbo"]
    },
    "reqlist" => [
      "3",
      "require-partition-offset",
      "1",
      "77324",
      "4",
      "require-uboot-variable",
      "uboot-env",
      "a.nerves_fw_platform",
      "rpi4",
      "4",
      "require-uboot-variable",
      "uboot-env",
      "a.nerves_fw_architecture",
      "arm"
    ]
  },
  {"task", "complete"} => %{
    {"on-finish", ""} => %{
      "funlist" => [
        "4",
        "raw_memset",
        "38693",
        "256",
        "0xff",
        "4",
        "raw_memset",
        "366368",
        "256",
        "0xff",
        "4",
        "raw_memset",
        "655412",
        "256",
        "0xff"
      ]
    },
    {"on-init", ""} => %{
      "funlist" => [
        "2",
        "mbr_write",
        "mbr-a",
        "3",
        "fat_mkfs",
        "63",
        "38630",
        "3",
        "fat_setlabel",
        "63",
        "BOOT-A",
        "3",
        "fat_mkdir",
        "63",
        "overlays",
        "2",
        "uboot_clearenv",
        "uboot-env",
        "4",
        "uboot_setenv",
        "uboot-env",
        "wifi_ssid",
        "${NERVES_WIFI_SSID}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "wifi_passphrase",
        "${NERVES_WIFI_PASSPHRASE}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "wifi_force",
        "${NERVES_WIFI_FORCE}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "nerves_serial_number",
        "${NERVES_SERIAL_NUMBER}",
        "4",
        "uboot_setenv",
        "uboot-env",
        "nerves_fw_active",
        "a",
        "4",
        "uboot_setenv",
        "uboot-env",
        "nerves_fw_devpath",
        "/dev/mmcblk0",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_application_part0_devpath",
        "/dev/mmcblk0p3",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_application_part0_fstype",
        "f2fs",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_application_part0_target",
        "/root",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_product",
        "berlin2024",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_description",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_version",
        "0.4.0",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_platform",
        "rpi4",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_architecture",
        "arm",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_author",
        "The Nerves Team",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_vcs_identifier",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_misc",
        "",
        "4",
        "uboot_setenv",
        "uboot-env",
        "a.nerves_fw_uuid",
        "${FWUP_META_UUID}"
      ]
    },
    {"on-resource", "bcm2711-rpi-4-b.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "bcm2711-rpi-4-b.dtb"]
    },
    {"on-resource", "bcm2711-rpi-400.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "bcm2711-rpi-400.dtb"]
    },
    {"on-resource", "bcm2711-rpi-cm4.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "bcm2711-rpi-cm4.dtb"]
    },
    {"on-resource", "cmdline.txt"} => %{"funlist" => ["3", "fat_write", "63", "cmdline.txt"]},
    {"on-resource", "config.txt"} => %{"funlist" => ["3", "fat_write", "63", "config.txt"]},
    {"on-resource", "dwc2.dtbo"} => %{"funlist" => ["3", "fat_write", "63", "overlays/dwc2.dtbo"]},
    {"on-resource", "fixup4.dat"} => %{"funlist" => ["3", "fat_write", "63", "fixup4.dat"]},
    {"on-resource", "i2c-mux.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/i2c-mux.dtbo"]
    },
    {"on-resource", "imx219.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx219.dtbo"]
    },
    {"on-resource", "imx296.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx296.dtbo"]
    },
    {"on-resource", "imx477.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx477.dtbo"]
    },
    {"on-resource", "imx708.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/imx708.dtbo"]
    },
    {"on-resource", "kernel8.img"} => %{"funlist" => ["3", "fat_write", "63", "kernel8.img"]},
    {"on-resource", "miniuart-bt.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/miniuart-bt.dtbo"]
    },
    {"on-resource", "ov5647.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/ov5647.dtbo"]
    },
    {"on-resource", "overlay_map.dtb"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/overlay_map.dtb"]
    },
    {"on-resource", "ramoops.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/ramoops.dtbo"]
    },
    {"on-resource", "rootfs.img"} => %{"funlist" => ["2", "raw_write", "77324"]},
    {"on-resource", "rpi-backlight.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/rpi-backlight.dtbo"]
    },
    {"on-resource", "rpi-ft5406.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/rpi-ft5406.dtbo"]
    },
    {"on-resource", "start4.elf"} => %{"funlist" => ["3", "fat_write", "63", "start4.elf"]},
    {"on-resource", "tc358743.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/tc358743.dtbo"]
    },
    {"on-resource", "vc4-kms-dsi-7inch.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/vc4-kms-dsi-7inch.dtbo"]
    },
    {"on-resource", "vc4-kms-v3d-pi4.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/vc4-kms-v3d-pi4.dtbo"]
    },
    {"on-resource", "vc4-kms-v3d.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/vc4-kms-v3d.dtbo"]
    },
    {"on-resource", "w1-gpio-pullup.dtbo"} => %{
      "funlist" => ["3", "fat_write", "63", "overlays/w1-gpio-pullup.dtbo"]
    },
    "require-unmounted-destination" => "true"
  }
}
