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
    lua51Packages.lua
    lua51Packages.plenary-nvim
    lua51Packages.luarocks-nix
    zsh
    atuin
    fzf
    tmux
    zoxide
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
    clang
    gcc
    rust-bin.stable.latest.default
    python312Full
    gnumake
    awsvpnclient
  ];
}
