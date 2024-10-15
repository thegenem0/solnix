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
    antidote = {
      enable = true;
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
    zoxide = {
      enable = true;
      enableZshIntegration = true;
    };
    pyenv = {
      enable = true;
      enableZshIntegration = true;
    };
  };
}
