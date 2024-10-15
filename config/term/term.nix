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
    kitty = {
        enable = true;
        package = pkgs.kitty;
        settings = {
          font_family = "JetBrainsMono Nerd Font Mono";
          font_size = 12;
          background_opacity = 0.75;
          confirm_os_window_close = 0;
          scrollback_lines = 2000;
          wheel_scroll_min_lines = 1;
          window_padding_width = 4;
          enable_audio_bell = false;
        };
    };
    zsh = {
      enable = true;
      package = pkgs.zsh;
      antidote = {
        enable = true;
        package = pkgs.antidote;
        plugins = [
          "reegnz/aws-vault-zsh-plugin"
          "lukechilds/zsh-nvm"
          "zsh-users/zsh-syntax-highlighting"
          "Aloxaf/fzf-tab"
          "MichaelAquilina/zsh-auto-notify"
          "unixorn/autoupdate-antigen.zshplugin"
          "reegnz/jq-zsh-plugin"
          "aubreypwd/zsh-plugin-reload"
          "qoomon/zsh-lazyload"
        ];
      };
    };
    starship = {
      enable = true;
      package = pkgs.starship;
    };
    atuin = {
      enable = true;
      package = pkgs.atuin;
    };
    fzf = {
      enable = true;
      package = pkgs.fzf;
      enableZshIntegration = true;
    };
    tmux = {
      enable = true;
      package = pkgs.tmux;
    };
    zoxide = {
      enable = true;
      package = pkgs.zoxide;
      enableZshIntegration = true;
    };
    pyenv = {
      enable = true;
      package = pkgs.pyenv;
      enableZshIntegration = true;
    };
  };
}
