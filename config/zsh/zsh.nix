{
  pkgs,
  lib,
  host,
  config,
  ...
}:
{
  programs.zsh = {
    enable = true;
  };

  home.file.".zshrc".source = ./zshrc;
  home.file.".scripts".source = ./scripts;
}
