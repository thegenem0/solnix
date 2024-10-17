{ pkgs }:

pkgs.writeShellScriptBin "notifications-open" ''
  sleep 0.1
  ${pkgs.swaynotificationcenter}/bin/swaync-client -t &
''
