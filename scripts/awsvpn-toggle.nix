{ pkgs }:

pkgs.writeShellScriptBin "awsvpn-toggle" ''
  if sudo pgrep -x "aws-vpn-client" > /dev/null; then
    sudo pkill "aws-vpn-client"
    sudo pkill "openvpn"
    sudo killall -9 openvpn
  else
    awsvpnclient start --config ~/.vpn/hace-main.ovpn > /dev/null 2>&1 &
  fi
''

