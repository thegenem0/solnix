{
  pkgs,
  lib,
  host,
  config,
  ...
}:
let
  zshrc = ./zshrc;
  zshScripts = ./scripts;
in
{
  home.file.".zshrc".text = builtins.readFile zshrc;

  home.file.".config/zsh/scripts" = {
    source = zshScripts;
    target = "link";
  };

  programs.zsh = {
    enable = true;
  };
}
