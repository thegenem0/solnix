{ pkgs, username, ... }: {
  nix.extraOptions = ''
    trusted-users = root ${username}
  '';

  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${username}";
      extraGroups = [ "networkmanager" "wheel" "libvirtd" "scanner" "lp" ];
      shell = pkgs.zsh;
      ignoreShellProgramCheck = true;
      packages = with pkgs; [
        slack
        vesktop
        jetbrains.idea-ultimate
        jetbrains.clion
        jetbrains.datagrip
        jetbrains.webstorm
        jetbrains.pycharm-professional
        jetbrains.rust-rover
        gimp
        lazygit
        lazydocker
        awscli2
        aws-vault
        nodejs_20
        go
        zig
        postman
        libreoffice
        guvcview
        zathura
        devenv
        direnv
        glab
        cloc
        obsidian
        obs-studio
        emote
      ];
    };
  };
}
