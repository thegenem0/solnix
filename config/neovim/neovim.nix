{ pkgs, inputs, ... }:

{
  home.file.".config/nvim".source = ./nvim;
  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
    };
  };
}