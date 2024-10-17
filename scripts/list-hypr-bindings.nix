{ pkgs, host, ... }:

pkgs.writeShellScriptBin "list-hypr-bindings" (builtins.readFile ./bash/hypr_bindings.sh)
