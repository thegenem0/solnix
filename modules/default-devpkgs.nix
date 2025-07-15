# This includes all development related packages that I want on all systems.

{ pkgs, ... }:
let
  snitch = pkgs.callPackage ../custom/snitch.nix {
    inherit (pkgs) lib buildGoModule fetchFromGitHub;
  };
in {
  virtualisation = {
    libvirtd.enable = true;
    docker = {
      enable = true;
      enableOnBoot = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
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
    jq
    git
    htop
    unzip
    unrar
    ripgrep
    fd
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
    devenv
    direnv
    groff
    zip
    bind
    docker-compose
    qmk
    buf
    snitch
    dmidecode
    kubectl
  ];
}
