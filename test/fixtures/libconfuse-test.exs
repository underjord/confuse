%{
  {:function, "func"} => [1, 2],
  {:function, "include"} => ~c"inc.conf",
  {"bookmark", "ftp.du.se"} => %{
    {"proxy", ""} => %{"exclude" => [".com.net"]},
    "login" => "ftp",
    "machine" => "ftp.du.se"
  },
  {"bookmark", "gazonk"} => %{
    {"proxy", ""} => %{},
    "directory" => "/pub/dir with spaces/\\\nmore",
    "login" => "joe",
    "machine" => "ssh://localhost",
    "passive-mode" => "true",
    "port" => 22
  },
  {"bookmark", "heimdal"} => %{
    {"proxy", ""} => %{
      "exclude" => [".aol.com", ".sf.net"],
      "host" => "${HOST:-localhost}",
      "type" => 1
    },
    "directory" => "/pub/heimdal/src",
    "login" => "anonymous",
    "machine" => "ftp://ftp.pdc.kth.se:21",
    "password" => "${ANONPASS:-anonymous@}"
  },
  "BackLog" => 2_147_483_647,
  "ask-quit" => "maybe",
  "ask-quit-array" => ["no", "yes", "yes"],
  "probe-device" => "eth1"
}
