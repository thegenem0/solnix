{
  pkgs,
  lib,
  host,
  config,
  ...
}:
{
  home.file.".zshrc".source = ./zshrc;
  home.file.".scripts".source = ./scripts;
  home.file.".zsh/completions".source = ./completions;

  programs.zsh = {
    enable = true;
  };
}
