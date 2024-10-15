{ pkgs, ... }:

{
  programs = {
    firefox.enable = true;
    virt-manager.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    nwg-look
    nwg-displays
    firefox
    brave
    cmatrix
    ffmpeg
    virt-viewer
    appimage-run
    networkmanagerapplet
    discord
    file-roller
    swaynotificationcenter
    imv
    mpv
    spotify
    gimp
    hyprpicker
    yad
    pavucontrol
    jetbrains-toolbox
  ];
}
