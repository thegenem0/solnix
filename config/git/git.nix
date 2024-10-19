{ config, ... }:

{
  programs.git.enable = true;

  home.file = {
    ".gitconfig".source = ./gitconfig;
    "dev/personal/.gitconfig.personal".source = ./gitconfig.personal;
    "dev/work/.gitconfig.work".source = ./gitconfig.work;
  };

  home.sessionPath = [
    "${config.home.homeDirectory}/dev"
    "${config.home.homeDirectory}/dev/personal"
    "${config.home.homeDirectory}/dev/work"
  ];

  home.activation = {
   createDirs = ''
     mkdir -p ${config.home.homeDirectory}/dev
     mkdir -p ${config.home.homeDirectory}/dev/personal
     mkdir -p ${config.home.homeDirectory}/dev/work
   '';
  };
}

