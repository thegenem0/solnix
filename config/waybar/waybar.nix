{
  pkgs,
  lib,
  host,
  config,
  ...
}:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../hosts/${host}/variables.nix) systemTheme primaryMonitor;
  inherit (import ../themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
  customEmpty = {
          format = " ";
  };
  hyprlandWorkspaces = {
    on-click = "activate";
    active-only = false;
    all-outputs = false;
    format = "{}";
    format-icons = {
        urgent = "";
        active = "";
        default = "";
    };
  };
  customWaymedia = {
    format = "{}";
    exec = "~/.config/waybar/scripts/waymedia/waymedia";
    interval = 1;
    limit = 60;
    on-click = "playerctl play-pause";
    on-scroll-up = "playerctl next";
    on-scroll-down = "playerctl previous";
    play-icon = " ";
    pause-icon = " ";
    divider = " - ";
    pattern = "{}-{artist}{divider}{title}";
  };
  clock = {
    format = '' {:L%H:%M}'';
    tooltip = true;
    tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
    on-click = "sleep 0.1 && hyprshade toggle night-light";
  };
  pulseaudio = {
    format = "{icon} {volume}% {format_source}";
    format-bluetooth = "{volume}% {icon} {format_source}";
    format-bluetooth-muted = " {icon} {format_source}";
    format-muted = " {format_source}";
    format-source = " {volume}%";
    format-source-muted = "";
    format-icons = {
      headphone = "";
      hands-free = "";
      headset = "";
      phone = "";
      portable = "";
      car = "";
      default = [
        ""
        ""
        ""
      ];
    };
    on-click = "sleep 0.1 && pavucontrol";
  };
  bluetooth = {
    format = " {status}";
    format-disabled = "";
    format-off = "";
    interval = 30;
    on-click = "sleep 0.1 && blueman-manager";
    format-no-controller = "";
  };
  customExit = {
    tooltip = false;
    format = "";
    on-click = "sleep 0.1 && wlogout";
  };
  customNotification = {
    tooltip = false;
    format = "{icon} {}";
    format-icons = {
      notification = "<span foreground='red'><sup></sup></span>";
      none = "";
      dnd-notification = "<span foreground='red'><sup></sup></span>";
      dnd-none = "";
      inhibited-notification = "<span foreground='red'><sup></sup></span>";
      inhibited-none = "";
      dnd-inhibited-notification = "<span foreground='red'><sup></sup></span>";
      dnd-inhibited-none = "";
    };
    return-type = "json";
    exec-if = "which swaync-client";
    exec = "swaync-client -swb";
    on-click = "sleep 0.1 && notifications-open";
    escape = true;
  };
  network = {
    format-icons = [
      "󰤯"
      "󰤟"
      "󰤢"
      "󰤥"
      "󰤨"
    ];
    format-ethernet = " {bandwidthDownOctets}";
    format-wifi = "{icon} {signalStrength}%";
    format-disconnected = "󰤮";
    tooltip = false;
    on-click = "sleep 0.1 && networkmanagerapplet";
  };
  tray = {
    icon-size = 21;
    spacing = 10;
  };
  customSystem = {
    format = " ";
    tooltip = false;
  };
  cpu = {
    format = " {usage}% ";
    on-click = "kitty -e btop";
  };
  memory = {
    format = " {}% ";
    on-click = "kitty -e btop";
  };
  disk = {
    interval = 30;
    format = "󰋊 {percentage_used}% ";
    path = "/";
    on-click = "kitty -e btop";
  };
  hyprlandLanguage = {
    format = " {short}";
  };
  groupHardware = {
    orientation = "inherit";
    drawer = {
        transition-duration =  300;
        children-class = "not-memory";
        transition-left-to-right =  false;
    };
    modules = [
        "custom/system"
        "disk"
        "cpu"
        "memory"
        "hyprland/language"
        "custom/empty"
    ];
    on-click = "sleep 0.1 && btop";
  };
  battery = {
    states = {
      bg = 30;
      critical = 15;
    };
    format = "{icon} {capacity}%";
    format-charging = "󰂄 {capacity}%";
    format-plugged = "󱘖 {capacity}%";
    format-icons = [
      "󰁺"
      "󰁻"
      "󰁼"
      "󰁽"
      "󰁾"
      "󰁿"
      "󰂀"
      "󰂁"
      "󰂂"
      "󰁹"
    ];
    on-click = "";
    tooltip = false;
  };
in
with lib;
{
  home.file.".config/waybar/scripts".source = ./scripts;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
        output = "${primaryMonitor}";
        layer = "top";
        position = "top";
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        modules-center = [ "custom/waymedia" ];
        modules-left = [
          "custom/empty"
          "hyprland/workspaces"
        ];
        modules-right = [
          "pulseaudio"
          "bluetooth"
          "battery"
          "network"
          "group/hardware"
          "custom/empty"
          "tray"
          "clock"
          "custom/notification"
          "custom/exit"
        ];

        "custom/empty" = customEmpty;
        "hyprland/workspaces" = hyprlandWorkspaces;
        "custom/waymedia" = customWaymedia;
        "clock" = clock;
        "pulseaudio" = pulseaudio;
        "bluetooth" = bluetooth;
        "custom/exit" = customExit;
        "custom/notification" = customNotification;
        "network" = network;
        "tray" = tray;
        "custom/system" = customSystem;
        "cpu" = cpu;
        "memory" = memory;
        "disk" = disk;
        "hyprland/language" = hyprlandLanguage;
        "group/hardware" = groupHardware;
        "battery" = battery;
      }
      {
        output = "!${primaryMonitor}";
        layer = "top";
        position = "top";
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        modules-center = [ ];
        modules-left = [
          "custom/empty"
          "hyprland/workspaces"
        ];
        modules-right = [
          "group/hardware"
          "custom/empty"
          "tray"
          "clock"
          "custom/notification"
          "custom/exit"
        ];

        "custom/empty" = customEmpty;
        "hyprland/workspaces" = hyprlandWorkspaces;
        "custom/waymedia" = customWaymedia;
        "clock" = clock;
        "pulseaudio" = pulseaudio;
        "bluetooth" = bluetooth;
        "custom/exit" = customExit;
        "custom/notification" = customNotification;
        "network" = network;
        "tray" = tray;
        "custom/system" = customSystem;
        "cpu" = cpu;
        "memory" = memory;
        "disk" = disk;
        "hyprland/language" = hyprlandLanguage;
        "group/hardware" = groupHardware;
        "battery" = battery;
      }
    ];
    style = concatStrings [
      ''
        /* Global Styles */
        * {
            font-family: JetBrainsMono Nerd Font Mono;
            font-size: 16px;
            border-radius: 0px;
            border: none;
            min-height: 0px;
        }

        window#waybar {
            background: transparent;
            transition-property: background-color;
            border-radius: 30px;
            transition-duration: 0.5s;
        }

        /* Common Widget Styles */
        #pulseaudio,
        #network,
        #bluetooth,
        #battery,
        #group-hardware,
        #cpu,
        #memory,
        #disk,
        #language,
        #custom-waymedia,
        #clock,
        #custom-notification {
            background-color: ${currentTheme.bg};
            border: none;
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }

        /* Specific Adjustments */
        #pulseaudio.muted {
            background-color: ${currentTheme.info};
            color: ${currentTheme.info};
        }

        #battery {
            padding: 2px 15px 0px 10px;
        }

        /* Workspace Styles */
        #workspaces {
            background: transparent;
            margin: 2px 1px 3px 1px;
            padding: 0px 1px;
            border-radius: 15px;
            font-weight: bold;
            font-style: normal;
            opacity: 0.8;
            font-size: 16px;
            color: ${currentTheme.bg};
        }

        #workspaces button {
            padding: 0px 10px;
            margin: 4px 3px;
            border-radius: 15px;
            color: ${currentTheme.info};
            background-color: ${currentTheme.bg};
            transition: all 0.3s ease-in-out;
            opacity: 1.0;
        }

        #workspaces button.active {
            min-width: 40px;
        }

        #workspaces button:hover {
            color: ${currentTheme.highlight};
            opacity: 0.7;
        }

        /* Tooltip Styles */
        tooltip {
            border-radius: 10px;
            background-color: ${currentTheme.bg};
            opacity: 0.8;
            padding: 20px;
            margin: 0px;
        }

        tooltip label {
            color: ${currentTheme.info};
        }

        /* Battery Critical Animation */
        @keyframes blink {
            to {
                background-color: transparent;
                color: ${currentTheme.info};
            }
        }

        #battery.charging,
        #battery.plugged {
            background-color: ${currentTheme.bg};
            color: ${currentTheme.info};
        }

        #battery.critical:not(.charging) {
            background-color: ${currentTheme.error};
            color: ${currentTheme.info};
            animation: blink 0.5s linear infinite alternate;
        }

        /* Tray Styles */
        #tray {
            background-color: transparent;
            padding: 0px 15px 0px 0px;
        }

        #tray > .passive {
            -gtk-icon-effect: dim;
        }

        /* Custom Exit Widget */
        #custom-exit {
            margin: 0px 20px 0px 0px;
            padding: 0px;
            font-size: 16px;
            color: ${currentTheme.info};
        }

        /* Bluetooth Off State */
        #bluetooth.off {
            background-color: ${currentTheme.bg};
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
      ''
    ];
  };
}
