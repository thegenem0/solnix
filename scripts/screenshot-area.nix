{ pkgs }:

pkgs.writeShellScriptBin "screenshot-area" ''
  grim -g "$(slurp)" - | swappy -f -
''
