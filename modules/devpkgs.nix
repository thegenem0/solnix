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
    lua53Packages.lua
    lua53Packages.plenary-nvim
    lua53Packages.luarocks-nix
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
    lazygit
    lazydocker
    awscli2
    aws-vault
    nodejs_20
    go
  ];
}
