{
  config,
  host,
  username,
  ...
}:
let
  inherit (import ../hosts/${host}/variables.nix) systemTheme;
  inherit (import ./themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
in
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "pidof hyprlock || hyprlock -q";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "pidof hyprlock || hyprlock -q & disown && systemctl suspend";
        text = "Suspend";
        keybind = "u";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono NF", FontAwesome, sans-serif;
        background-image: none;
        transition: 20ms;
      }

      window {
        background: url("/home/${username}/.config/.blurred_wallpaper");
      }

      button {
        color: ${currentTheme.fg};
        font-size: 20px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-style: solid;
        background-color: rgba(12, 12, 12, 0.3);
        border: 3px solid ${currentTheme.fg};
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }

      button:focus,
      button:active,
      button:hover {
        color: ${currentTheme.success};
        background-color: rgba(12, 12, 12, 0.5);
        border: 3px solid ${currentTheme.success};
      }

      #shutdown, #reboot, #logout, #suspend, #lock, #hibernate {
        margin: 10px;
        border-radius: 20px;
      }

      #shutdown {
        background-image: url("icons/shutdown.png");
      }
      #reboot {
        background-image: url("icons/reboot.png");
      }
      #logout {
        background-image: url("icons/logout.png");
      }
      #suspend {
        background-image: url("icons/suspend.png");
      }
      #lock {
        background-image: url("icons/lock.png");
      }
      #hibernate {
        background-image: url("icons/hibernate.png");
      }
    '';
  };
}
