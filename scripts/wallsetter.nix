{
  pkgs,
  username,
  ...
}:

pkgs.writeShellScriptBin "wallsetter" (builtins.readFile ./bash/wallsetter.sh)
