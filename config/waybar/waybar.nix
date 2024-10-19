{
  pkgs,
  lib,
  host,
  config,
  ...
}:
let
  betterTransition = "all 0.3s cubic-bezier(.55,-0.68,.48,1.682)";
  inherit (import ../../hosts/${host}/variables.nix) clock24h systemTheme;
  inherit (import ../themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
in
with lib;
{
  home.file.".config/waybar/scripts".source = ./scripts;

  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = [
      {
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

        "custom/empty" = {
          format = " ";
        };

        "hyprland/workspaces" = {
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

        "custom/waymedia" = {
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

        "clock" = {
          format = if clock24h == true then '' {:L%H:%M}'' else '' {:L%I:%M %p}'';
          tooltip = true;
          tooltip-format = "<big>{:%A, %d.%B %Y }</big>\n<tt><small>{calendar}</small></tt>";
          on-click = "sleep 0.1 && hyprshade toggle night-light";
        };

        "pulseaudio" = {
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

        "bluetooth" = {
          format = " {status}";
          format-disabled = "";
          format-off = "";
          interval = 30;
          on-click = "sleep 0.1 && blueman-manager";
          format-no-controller = "";
        };

        "custom/exit" = {
          tooltip = false;
          format = "";
          on-click = "sleep 0.1 && wlogout";
        };

        "custom/notification" = {
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

        "network" = {
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

        "tray" = {
          icon-size = 21;
          spacing = 10;
        };

        "custom/system" = {
          format = " ";
          tooltip = false;
        };

        "cpu" = {
          format = " {usage}% ";
          on-click = "kitty -e btop";
        };

        "memory" = {
          format = " {}% ";
          on-click = "kitty -e btop";
        };

        "disk" = {
          interval = 30;
          format = "󰋊 {percentage_used}% ";
          path = "/";
          on-click = "kitty -e btop";
        };

        "hyprland/language" = {
          format = " {short}";
        };


        "group/hardware" = {
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

        "battery" = {
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
      }
    ];
    style = concatStrings [
      ''
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
            transition-duration: .5s;
        }
        #workspaces {
            background: transparent;
            margin: 2px 1px 3px 1px;
            padding: 0px 1px;
            border-radius: 15px;
            border: 0px;
            font-weight: bold;
            font-style: normal;
            opacity: 0.8;
            font-size: 16px;
            color: ${currentTheme.bg};
        }
        #workspaces button {
            padding: 0px 10px;
            border: 0px solid;
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: ${currentTheme.info};
            background-color: ${currentTheme.bg};
            transition: all 0.3s ease-in-out;
            opacity: 1.0;
        }
        #workspaces button.active {
            color: ${currentTheme.info};
            background: ${currentTheme.bg};
            border-radius: 15px;
            min-width: 40px;
            transition: all 0.3s ease-in-out;
            opacity: 1.0;
        }
        #workspaces button:hover {
            color: ${currentTheme.highlight};
            background: ${currentTheme.bg};
            border-radius: 15px;
            opacity: 0.7;
        }
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
        #clock {
            background-color: ${currentTheme.bg};
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            opacity: 0.8;
            border: 0px solid;
        }
        #pulseaudio {
            background-color:  ${currentTheme.bg};
            border: 0px solid;
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #pulseaudio.muted {
            background-color: ${currentTheme.info};
            border: 0px solid;
            color: ${currentTheme.info};
        }
        #network {
            background-color: ${currentTheme.bg};
            border: 0px solid;
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #network.ethernet {
            background-color:  ${currentTheme.bg};
            border: 0px solid;
            color: ${currentTheme.info};
        }
        #network.wifi {
            background-color: ${currentTheme.bg};
            border: 0px solid;
            color: ${currentTheme.info};
        }
        #bluetooth,
        #bluetooth.on,
        #bluetooth.connected {
            background-color: ${currentTheme.bg};
            border: 0px solid;
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #bluetooth.off {
            background-color: ${currentTheme.bg};
            padding: 0px;
            margin: 0px;
        }
        #battery {
            background-color: ${currentTheme.bg};
            border: 0px solid;
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 15px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #battery.charging,
        #battery.plugged {
            color: ${currentTheme.info};
            border: 0px solid;
            background-color: ${currentTheme.bg};
        }
        @keyframes blink {
            to {
                background-color: transparent;
                color: ${currentTheme.info};
            }
        }
        #battery.critical:not(.charging) {
            background-color: ${currentTheme.error};
            border: 0px solid;
            color: ${currentTheme.info};
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }
        #tray {
            background-color: transparent;
            padding: 0px 15px 0px 0px;
        }
        #tray>.passive {
            -gtk-icon-effect: dim;
        }
        #custom-exit {
            margin: 0px 20px 0px 0px;
            padding: 0px;
            font-size: 24px;
            color: ${currentTheme.info};
        }
        #custom-notification {
            font-weight: bold;
            background: ${currentTheme.bg};
            color: ${currentTheme.info};
            border: 0px solid;
            border-radius: 15px;
            padding: 2px 15px 0px 10px;
            margin: 5px 15px 5px 0px;
        }
        #custom-waymedia {
            background: ${currentTheme.bg};
            color: ${currentTheme.info};
            font-size: 16px;
            border: 0px solid;
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
        }
        #custom-system,
        #disk,
        #memory,
        #cpu,
        #language {
            margin: 0px;
            padding: 0px;
            font-size: 16px;
            color: ${currentTheme.info};
        }
        #group-hardware {
            background-color: ${currentTheme.bg};
            border: 0px solid;
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #cpu,
        #memory,
        #disk,
        #language {
            background-color: ${currentTheme.bg};
            border: 0px solid;
            font-size: 16px;
            color: ${currentTheme.info};
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
      ''
    ];
  };
}
