{ ... }:

{
  home.file.".config/nvim".source = ./nvim;
  home.file.".ideavimrc".source = ../misc/ideavimrc;

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
