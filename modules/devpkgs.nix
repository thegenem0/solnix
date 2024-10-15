{ pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    neovim
    zsh
    atuin
    fzf
    tmux
    zoxide
    pyenv
    antidote
    wget
    eza
    git
    htop
    unzip
    unrar
    ripgrep
    bat
    tree
    ncdu
    duf
  ];
}
