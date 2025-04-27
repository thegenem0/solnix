{ pkgs, username, host, lib, ... }:

{
  # Home Manager Settings
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    stateVersion = "23.11";
  };

  # Import Program Configurations
  imports = [
    ../../config/fastfetch
    ../../config/hyprland.nix
    ../../config/rofi/rofi-launcher.nix
    ../../config/rofi/rofi-wallselect.nix
    ../../config/swaync.nix
    ../../config/waybar/waybar.nix
    ../../config/git/git.nix
    ../../config/ssh/ssh.nix
    ../../config/term/term.nix
    ../../config/wlogout.nix
    ../../config/fastfetch
    ../../config/spicetify.nix
  ];

  home.file = {
    "Pictures/Wallpapers".source = ../../config/wallpapers;
    ".config/wlogout/icons".source = ../../config/wlogout;

    ".logo.icon".source = ../../config/misc/logo.png;
    ".config/logo.jpg".source = ../../config/misc/logo.png;

    ".config/swappy/config".text = ''
      [Default]
      save_dir=/home/${username}/Pictures/Screenshots
      save_filename_format=swappy-%Y%m%d-%H%M%S.png
      show_panel=false
      line_size=5
      text_size=20
      text_font=Ubuntu
      paint_mode=brush
      early_exit=true
      fill_shape=false
    '';
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = [ "qemu:///system" ];
      uris = [ "qemu:///system" ];
    };
  };

  stylix.targets = {
    waybar.enable = false;
    rofi.enable = false;
    hyprland.enable = false;
  };

  gtk = {
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    gtk3.extraConfig = { gtk-application-prefer-dark-theme = 1; };
    gtk4.extraConfig = { gtk-application-prefer-dark-theme = 1; };
  };
  qt = {
    enable = true;
    style.name = lib.mkForce "adwaita-dark";
    platformTheme.name = lib.mkForce "gtk3";
  };

  # Scripts
  home.packages = [
    (import ../../scripts/notifications-open.nix { inherit pkgs; })
    (import ../../scripts/nvidia-offload.nix { inherit pkgs; })
    (import ../../scripts/wallsetter.nix {
      inherit pkgs;
      inherit username;
    })
    (import ../../scripts/rofi-launcher.nix { inherit pkgs; })
    (import ../../scripts/screenshot-area.nix { inherit pkgs; })
    (import ../../scripts/list-hypr-bindings.nix {
      inherit pkgs;
      inherit host;
    })
    (import ../../scripts/awsvpn-toggle.nix { inherit pkgs; })
    (import ../../scripts/awsvpn-status.nix { inherit pkgs; })
    (import ../../scripts/gen-pr.nix { inherit pkgs; })
  ];

  services = {
    hypridle = {
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };
        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };
  };

  programs = {
    gh.enable = true;
    btop = {
      enable = true;
      settings = { vim_keys = true; };
    };
    home-manager.enable = true;
    hyprlock = lib.mkForce {
      enable = true;
      settings = {
        general = {
          disable_loading_bar = true;
          grace = 0;
          hide_cursor = true;
          no_fade_in = false;
        };
        background = [{
          path = "/home/${username}/.config/.blurred_wallpaper";
          blur_passes = 3;
          blur_size = 8;
        }];
        image = [{
          path = "/home/${username}/.config/logo.jpg";
          size = 150;
          border_size = 4;
          border_color = "rgb(0, 0, 255, 0.5)";
          rounding = -1; # Negative means circle
          position = "0, 200";
          halign = "center";
          valign = "center";
        }];
        input-field = [{
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(CFE6F4)";
          inner_color = "rgb(657DC2)";
          outer_color = "rgb(0D0E15)";
          outline_thickness = 5;
          placeholder_text = "Password...";
          shadow_passes = 2;
        }];
      };
    };
  };
}
