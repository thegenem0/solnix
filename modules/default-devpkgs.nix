# This includes all development related packages that I want on all systems.

{ pkgs, ... }: {
  virtualisation = {
    libvirtd.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      dockerSocket.enable = true;
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
    podman-compose
    qmk
    buf
  ];
}
