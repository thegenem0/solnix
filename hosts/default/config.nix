{ config, pkgs, inputs, host, username, options, lib, ... }:
with lib;
let
  inherit (import ./variables.nix) keyboardLayout amd nvidia intel systemTheme;
  inherit (import ../../config/themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
in {
  imports = [
    ./hardware.nix
    ./users.nix
    ../../modules/amd-drivers.nix
    ../../modules/nvidia-drivers.nix
    ../../modules/nvidia-prime-drivers.nix
    ../../modules/intel-drivers.nix
    ../../modules/vm-guest-services.nix
    ../../modules/local-hardware-clock.nix
    ../../modules/default-apps.nix
    ../../modules/default-devpkgs.nix
  ];

  boot = {
    # Kernel
    kernelPackages = pkgs.linuxPackages_zen;
    # This is for OBS Virtual Cam Support
    kernelModules = [ "v4l2loopback" ];
    extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
    extraModprobeConfig = lib.mkIf nvidia.enable ''
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3"
    '';
    # Needed For Some Steam Games
    kernel.sysctl = { "vm.max_map_count" = 2147483643; };
    # Bootloader.
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    # Make /tmp a tmpfs
    tmp = {
      useTmpfs = false;
      tmpfsSize = "30%";
    };
    # Appimage Support
    binfmt.registrations.appimage = {
      wrapInterpreterInShell = false;
      interpreter = "${pkgs.appimage-run}/bin/appimage-run";
      recognitionType = "magic";
      offset = 0;
      mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
      magicOrExtension = "\\x7fELF....AI\\x02";
    };
    plymouth.enable = true;
  };

  # Styling Options
  stylix = {
    enable = true;
    # This is required even if we override everything
    # See https://github.com/danth/stylix/issues/200
    image = ../../config/wallpapers/9162783.jpg;

    override = mkIf (systemTheme.name != "stylix") {
      base00 = currentTheme.bg;
      base01 = currentTheme.secondaryBg;
      base02 = currentTheme.selectionBg;
      base03 = currentTheme.inactiveFg;
      base04 = currentTheme.subtleFg;
      base05 = currentTheme.fg;
      base06 = currentTheme.highlightFg;
      base07 = currentTheme.brightFg;
      base08 = currentTheme.error;
      base09 = currentTheme.warning;
      base0A = currentTheme.highlight;
      base0B = currentTheme.success;
      base0C = currentTheme.info;
      base0D = currentTheme.accent;
      base0E = currentTheme.special;
      base0F = currentTheme.extra;
    };

    polarity = "dark";
    opacity.terminal = 0.8;
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 32;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      serif = {
        package = pkgs.montserrat;
        name = "Montserrat";
      };
      sizes = {
        applications = 12;
        terminal = 15;
        desktop = 11;
        popups = 12;
      };
    };
  };

  # Extra Module Options
  drivers = {
    amdgpu.enable = amd.enable;
    nvidia.enable = nvidia.enable;
    # nvidia-prime = nvidia.prime;
    intel.enable = intel.enable;
  };
  vm.guest-services.enable = false;
  local.hardware-clock.enable = false;

  # Enable networking
  networking = {
    networkmanager.enable = true;
    hostName = host;
    timeServers = options.networking.timeServers.default ++ [ "pool.ntp.org" ];
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    hyprland = {
      enable = true;
      package =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };

  nixpkgs.config.allowUnfree = true;

  users = { mutableUsers = true; };

  environment.systemPackages = with pkgs;
    [
      killall
      openssl
      lolcat
      libvirt
      lxqt.lxqt-policykit
      lm_sensors
      libnotify
      v4l-utils
      ydotool
      wl-clipboard
      pciutils
      socat
      lshw
      pkg-config
      meson
      ninja
      brightnessctl
      swappy
      inxi
      playerctl
      nh
      nixfmt-rfc-style
      libvirt
      grim
      slurp
      kanata
    ] ++ [ inputs.swww.packages.${pkgs.system}.swww ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-emoji
      noto-fonts-cjk-sans
      font-awesome
      material-icons
    ];
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal ];
  };

  # Services to start
  services = {
    pulseaudio.enable = false;
    blueman.enable = true;
    xserver = {
      enable = true;
      xkb = {
        layout = "${keyboardLayout}";
        variant = "";
      };
      displayManager = {
        gdm = {
          enable = true;
          wayland = true;
        };
      };
    };
    smartd = {
      enable = false;
      autodetect = true;
    };
    libinput.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    openssh.enable = true;
    flatpak.enable = false;
    printing = {
      enable = true;
      drivers = [
        # pkgs.hplipWithPlugin
      ];
    };
    gnome.gnome-keyring.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
    };
    kanata = {
      enable = true;
      keyboards = {
        default = {
          devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
          configFile = ../../config/misc/kanata/config.kbd;
        };
      };
    };
  };
  systemd = {
    services = {
      flatpak-repo = {
        path = [ pkgs.flatpak ];
        script = ''
          flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        '';
      };
    };
  };
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    sane = {
      enable = true;
      extraBackends = [ pkgs.sane-airscan ];
      disabledDefaultBackends = [ "escl" ];
    };
    logitech.wireless = {
      enable = false;
      enableGraphical = false;
    };
  };

  # Security / Polkit
  security = {
    rtkit.enable = true;
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function(action, subject) {
          if (
            subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
              )
            )
          {
            return polkit.Result.YES;
          }
        })
      '';
    };
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
    sudo = {
      enable = true;
      extraRules = [{
        users = [ "${username}" ];
        commands = [{
          command = "/usr/bin/awsvpnclient";
          options = [ "NOPASSWD" ];
        }];
      }];
    };
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" ];
      substituters =
        [ "https://hyprland.cachix.org" "https://devenv.cachix.org" ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # OpenGL
  hardware.graphics = { enable = true; };

  console.keyMap = "${keyboardLayout}";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
