{ pkgs }:

pkgs.writeShellScriptBin "awsvpn-status" ''
  if ip link show dev tun0 > /dev/null; then
    echo '{"status": "On", "class": "connected"}'
  else
    echo '{"status": "Off", "class": "disconnected"}'
  fi
''
