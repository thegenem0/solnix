{
  lib,
  username,
  host,
  config,
  ...
}:

let
  inherit (import ../hosts/${host}/variables.nix)
    browser
    terminal
    extraMonitorSettings
    keyboardLayout
    ;
in
with lib;
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
    settings =
      let
        mod = "ALT";
      in
      {
        "$mod" = "${mod}";
        env = [
          "NIXOS_OZONE_WL, 1"
          "NIXPKGS_ALLOW_UNFREE, 1"
          "XDG_CURRENT_DESKTOP, Hyprland"
          "XDG_SESSION_TYPE, wayland"
          "XDG_SESSION_DESKTOP, Hyprland"
          "GDK_BACKEND, wayland, x11"
          "CLUTTER_BACKEND, wayland"
          "QT_QPA_PLATFORM=wayland;xcb"
          "QT_WAYLAND_DISABLE_WINDOWDECORATION, 1"
          "QT_AUTO_SCREEN_SCALE_FACTOR, 1"
          "SDL_VIDEODRIVER, x11"
          "MOZ_ENABLE_WAYLAND, 1"
        ];
        exec-once = [
          "dbus-update-activation-environment --systemd --all"
          "systemctl --user import-environment QT_QPA_PLATFORMTHEME WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
          "killall -q swww;sleep .5 && swww init"
          "killall -q waybar;sleep .5 && waybar"
          "killall -q swaync;sleep .5 && swaync"
          "nm-applet --indicator"
          "lxqt-policykit"
          "sleep 1.5 && swww img /home/${username}/Pictures/Wallpapers/beautifulmountainscape.jpg"
          "monitor=,preferred,auto,1"
        ];
        general = {
            gaps_in = 5;
            gaps_out = 20;
            border_size = 0;
            layout = "dwindle";
            resize_on_border = true;
            "col.active_border" = "rgb(${config.stylix.base16Scheme.base08}) rgb(${config.stylix.base16Scheme.base0C}) 45deg";
            "col.inactive_border" = "rgb(${config.stylix.base16Scheme.base01})";
        };
        input = {
            kb_layout = "${keyboardLayout}";
            follow_mouse = 1;
            sensitivity = 0;
            accel_profile = "flat";
            kb_options = [
              "grp:alt_shift_toggle"
              "caps:super"
            ];
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              scroll_factor = 0.8;
            };
        };
        windowrule = [
          "noborder,^(wofi)$"
          "center,^(wofi)$"
          "center,^(steam)$"
          "float, nm-connection-editor|blueman-manager"
          "float, swayimg|vlc|Viewnior|pavucontrol"
          "float, nwg-look|qt5ct|mpv"
          "float, zoom"
        ];
        workspace = [
          "1,monitor:DP-1,default:true"
          "2,monitor:DP-1"
          "3,monitor:DP-1"
          "4,monitor:DP-1"
          "5,monitor:DP-2,default:true"
          "6,monitor:DP-2"
          "7,monitor:DP-2"
          "8,monitor:DP-3,default:true"
          "9,monitor:DP-3"
        ];
        windowrulev2 = [
          "stayfocused, title:^()$,class:^(steam)$"
          "minsize 1 1, title:^()$,class:^(steam)$"
          "opacity 0.9 0.7, class:^(Brave)$"
          "opacity 0.9 0.7, class:^(thunar)$"
        ];
        gestures = {
          workspace_swipe = true;
          workspace_swipe_fingers = 3;
        };
        misc = {
          initial_workspace_tracking = 0;
          mouse_move_enables_dpms = true;
          key_press_enables_dpms = false;
        };
        animations = {
          enabled = true;
          bezier = [
            "wind, 0.05, 0.9, 0.1, 1.05"
            "winIn, 0.1, 1.1, 0.1, 1.1"
            "winOut, 0.3, -0.3, 0, 1"
            "liner, 1, 1, 1, 1"
          ];
          animation = [
            "windows, 1, 6, wind, slide"
            "windowsIn, 1, 6, winIn, slide"
            "windowsOut, 1, 5, winOut, slide"
            "windowsMove, 1, 5, wind, slide"
            "border, 1, 1, liner"
            "fade, 1, 10, default"
            "workspaces, 1, 5, wind"
          ];
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        bind = [
          "${mod}, Return, exec, ${terminal}"
          "${mod} SHIFT, Q, killactive"
          "${mod}, F, fullscreen"
          "${mod}, T, togglefloating"
          "${mod}, J, togglesplit"
          "${mod}, H, movefocus, l"
          "${mod}, L, movefocus, r"
          "${mod}, K, movefocus, u"
          "${mod}, J, movefocus, d"
          "${mod}, PRINT, exec, grim -g \"$(slurp)\" - | wl-copy"
          "${mod} SHIFT, L, exec, wlogout"
          "${mod} SHIFT, W, exec, ~/.config/rofi/wallpapers.sh"
          "${mod}, D, exec, ~/.config/rofi/launcher.sh"
          "${mod}, 1, workspace, 1"
          "${mod}, 2, workspace, 2"
          "${mod}, 3, workspace, 3"
          "${mod}, 4, workspace, 4"
          "${mod}, 5, workspace, 5"
          "${mod}, 6, workspace, 6"
          "${mod}, 7, workspace, 7"
          "${mod}, 8, workspace, 8"
          "${mod}, 9, workspace, 9"
          "${mod}, 0, workspace, 10"
          "${mod} SHIFT, 1, movetoworkspace, 1"
          "${mod} SHIFT, 2, movetoworkspace, 2"
          "${mod} SHIFT, 3, movetoworkspace, 3"
          "${mod} SHIFT, 4, movetoworkspace, 4"
          "${mod} SHIFT, 5, movetoworkspace, 5"
          "${mod} SHIFT, 6, movetoworkspace, 6"
          "${mod} SHIFT, 7, movetoworkspace, 7"
          "${mod} SHIFT, 8, movetoworkspace, 8"
          "${mod} SHIFT, 9, movetoworkspace, 9"
          "${mod} SHIFT, 0, movetoworkspace, 10"
          ",XF86AudioRaiseVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume,exec,wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPrev, exec, playerctl previous"
          ",XF86MonBrightnessDown,exec,brightnessctl set 5%-"
          ",XF86MonBrightnessUp,exec,brightnessctl set +5%"
        ];
        bindm = [
          "${mod}, mouse:272, movewindow"
          "${mod}, mouse:273, resizewindow"
        ];
        binde = [
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ];
      };
    extraConfig =
      let
      in
      concatStrings [
        ''
          ${extraMonitorSettings}
        ''
      ];
  };
}
