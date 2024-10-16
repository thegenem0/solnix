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
        margin-top = 14;
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
          "custom/exit"
          "custom/notification"
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
          on-click = "sleep 0.1 && task-waybar";
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
          format = "/  {usage}% ";
          on-click = "kitty -e btop";
        };

        "memory" = {
          format = "/  {}% ";
          on-click = "kitty -e btop";
        };

        "disk" = {
          interval = 30;
          format = "󰋊 {percentage_used}% ";
          path = "/";
          on-click = "kitty -e btop";
        };

        "hyprland/language" = {
          format = "/  {short}";
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
        };

        "battery" = {
          states = {
            warning = 30;
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
            background-color: rgba(50, 50, 50, 0.5);
            border-bottom: 0px solid ${currentTheme.fg};               /* base05 */
            background: rgba(50, 50, 50, 0.8);
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
            color: ${currentTheme.special};                          /* base0E */
        }
        #workspaces button {
            padding: 0px 5px;
            border: 3px solid ${currentTheme.special};               /* base0E */
            margin: 4px 3px;
            border-radius: 15px;
            border: 0px;
            color: ${currentTheme.success};                          /* base0B */
            background-color: ${currentTheme.special};               /* base0E */
            transition: all 0.3s ease-in-out;
            opacity: 0.4;
        }
        #workspaces button.active {
            color: ${currentTheme.success};                          /* base0B */
            background: ${currentTheme.special};                     /* base0E */
            border-radius: 15px;
            min-width: 40px;
            transition: all 0.3s ease-in-out;
            opacity: 1.0;
        }
        #workspaces button:hover {
            color: ${currentTheme.special};                          /* base0E */
            background: ${currentTheme.special};                     /* base0E */
            border-radius: 15px;
            opacity: 0.7;
        }
        tooltip {
            border-radius: 10px;
            background-color: transparent;
            opacity: 0.8;
            padding: 20px;
            margin: 0px;
        }
        tooltip label {
            color: ${currentTheme.special};                          /* base0E */
        }
        #clock {
            background-color: transparent;
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
            border-radius: 15px;
            padding: 1px 10px 0px 10px;
            margin: 3px 15px 3px 0px;
            opacity: 0.8;
            border: 3px solid ${currentTheme.success};               /* base0B */
        }
        #pulseaudio {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #pulseaudio.muted {
            background-color: ${currentTheme.success};               /* base0B */
            border: 3px solid ${currentTheme.success};               /* base0B */
            color: ${currentTheme.special};                          /* base0E */
        }
        #network {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #network.ethernet {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            color: ${currentTheme.special};                          /* base0E */
        }
        #network.wifi {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            color: ${currentTheme.special};                          /* base0E */
        }
        #bluetooth,
        #bluetooth.on,
        #bluetooth.connected {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #bluetooth.off {
            background-color: transparent;
            padding: 0px;
            margin: 0px;
        }
        #battery {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
            border-radius: 15px;
            padding: 2px 15px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #battery.charging,
        #battery.plugged {
            color: ${currentTheme.special};                          /* base0E */
            border: 3px solid ${currentTheme.success};               /* base0B */
            background-color: transparent;
        }
        @keyframes blink {
            to {
                background-color: transparent;
                color: ${currentTheme.special};                      /* base0E */
            }
        }
        #battery.critical:not(.charging) {
            background-color: #f53c3c;
            border: 3px solid ${currentTheme.success};               /* base0B */
            color: ${currentTheme.special};                          /* base0E */
            animation-name: blink;
            animation-duration: 0.5s;
            animation-timing-function: linear;
            animation-iteration-count: infinite;
            animation-direction: alternate;
        }
        #tray {
            padding: 0px 15px 0px 0px;
        }
        #tray>.passive {
            -gtk-icon-effect: dim;
        }
        #custom-exit {
            margin: 0px 20px 0px 0px;
            padding: 0px;
            font-size: 20px;
            color: ${currentTheme.success};                          /* base0B */
        }
        #custom-notification {
            font-weight: bold;
            background: ${currentTheme.special};                     /* base0E */
            color: ${currentTheme.bg};                               /* base00 */
            border: 3px solid ${currentTheme.success};               /* base0B */
            border-radius: 15px;
            padding: 2px 15px 0px 10px;
            margin: 5px 15px 5px 0px;
        }
        #custom-waymedia {
            color: ${currentTheme.success};                          /* base0B */
        }
        #custom-system,
        #disk,
        #memory,
        #cpu,
        #language {
            margin: 0px;
            padding: 0px;
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
        }
        #group-hardware {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
        #cpu,
        #memory,
        #disk {
            background-color: transparent;
            border: 3px solid ${currentTheme.success};               /* base0B */
            font-size: 16px;
            color: ${currentTheme.special};                          /* base0E */
            border-radius: 15px;
            padding: 2px 10px 0px 10px;
            margin: 5px 15px 5px 0px;
            opacity: 0.8;
        }
      ''
    ];
  };
}
