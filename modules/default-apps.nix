# This includes default apps that I want on all systems.
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
      plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];
    };
  };

  environment.systemPackages = with pkgs; [
    nwg-look
    nwg-displays
    firefox
    cmatrix
    ffmpeg
    virt-viewer
    appimage-run
    networkmanagerapplet
    file-roller
    swaynotificationcenter
    imv
    mpv
    hyprpicker
    yad
    pavucontrol
    imagemagick
  ];
}
