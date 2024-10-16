{
  config,
  host,
  ...
}:
let
  inherit (import ../hosts/${host}/variables.nix) systemTheme;
  inherit (import ./themes/theme.nix) getTheme;
  currentTheme = getTheme systemTheme;
in
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "shutdown";
        action = "sleep 1; systemctl poweroff";
        text = "Shutdown";
        keybind = "s";
      }
      {
        "label" = "reboot";
        "action" = "sleep 1; systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
      {
        "label" = "logout";
        "action" = "sleep 1; hyprctl dispatch exit";
        "text" = "Exit";
        "keybind" = "e";
      }
      {
        "label" = "suspend";
        "action" = "sleep 1; systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "lock";
        "action" = "sleep 1; hyprlock";
        "text" = "Lock";
        "keybind" = "l";
      }
      {
        "label" = "hibernate";
        "action" = "sleep 1; systemctl hibernate";
        "text" = "Hibernate";
        "keybind" = "h";
      }
    ];
    style = ''
      * {
        font-family: "JetBrainsMono NF", FontAwesome, sans-serif;
        background-image: none;
        transition: 20ms;
      }

      window {
        background-color: rgba(12, 12, 12, 0.1);
      }

      button {
        color: ${currentTheme.foreground};  # Use dynamic foreground color
        font-size: 20px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
        border-style: solid;
        background-color: rgba(12, 12, 12, 0.3);
        border: 3px solid ${currentTheme.foreground};  # Use dynamic border color
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
      }

      button:focus,
      button:active,
      button:hover {
        color: ${currentTheme.green};  # Use dynamic hover color
        background-color: rgba(12, 12, 12, 0.5);
        border: 3px solid ${currentTheme.green};  # Use dynamic border color for hover
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
