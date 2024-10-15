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

  programs = {
    zsh = {
      enable = true;
    };
    atuin = {
      enable = true;
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
    };
    tmux = {
      enable = true;
    };
  };
}
