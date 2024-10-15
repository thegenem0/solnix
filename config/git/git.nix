{
  pkgs,
  lib,
  host,
  config,
  ...
}:
let
   globalGitConfig = ./gitconfig;
   personalGitConfig =  ./gitconfig.thegenem0;
   workGitConfig = ./gitconfig.work;
in
{
  programs.git.enable = true;

  home.file = {
    ".gitconfig".text = builtins.readFile globalGitConfig;
    "dev/personal/.gitconfig.thegenem0".text = builtins.readFile personalGitConfig;
    "dev/work/.gitconfig.work".text = builtins.readFile workGitConfig;
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

