{
  config,
  host,
  ...
}:
let
  inherit (import ../hosts/${host}/variables.nix) systemTheme;
  inherit (import ./themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
in
{
  services.swaync = {
    enable = true;
    settings = {
      positionX = "center";
      positionY = "top";
      control-center-positionX = "right";
      control-center-positionY = "top";
      control-center-margin-top = 10;
      control-center-margin-bottom = 10;
      control-center-margin-right = 10;
      control-center-margin-left = 10;
      notification-icon-size = 64;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 10;
      timeout-low = 5;
      timeout-critical = 0;
      fit-to-screen = false;
      control-center-width = 500;
      control-center-height = 1025;
      notification-window-width = 500;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = false;
      hide-on-action = true;
      script-fail-notify = true;
      widgets = [
        "title"
        "mpris"
        "volume"
        "backlight"
        "dnd"
        "notifications"
      ];
      widget-config = {
        title = {
          text = "Notification Center";
          clear-all-button = true;
          button-text = "󰆴 Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        label = {
          max-lines = 1;
          text = "Notification Center";
        };
        mpris = {
          image-size = 96;
          image-radius = 7;
        };
        volume = {
          label = "󰕾";
        };
        backlight = {
          label = "󰃟";
        };
      };
    };
    style = ''
      * {
          font-family: JetBrainsMono Nerd Font Mono;
          font-weight: bold;
        }
        .control-center .notification-row:focus,
        .control-center .notification-row:hover {
          opacity: 0.9;
          background: ${currentTheme.bg};  # Use theme background color
          border: ${currentTheme.accent} solid 2px;
        }
        .notification-row {
          outline: none;
          margin: 10px;
          padding: 0;
        }
        .notification {
          background: transparent;
          padding: 0;
          margin: 0px;
        }
        .notification-content {
          background: ${currentTheme.bg};  # Theme background
          padding: 10px;
          border-radius: 5px;
          border: 2px solid ${currentTheme.special};  # Dynamic accent color
          margin: 0;
        }
        .notification-default-action {
          margin: 0;
          padding: 0;
          border-radius: 5px;
        }
        .close-button {
          background: ${currentTheme.error};  # Dynamic red for close button
          color: ${currentTheme.bg};  # Background color for text contrast
          text-shadow: none;
          padding: 0;
          border-radius: 5px;
          margin-top: 5px;
          margin-right: 5px;
        }
        .close-button:hover {
          box-shadow: none;
          background: ${currentTheme.special};  # Hover state with accent color
          transition: all .15s ease-in-out;
          border: none;
        }
        .notification-action {
          border: 2px solid ${currentTheme.special};  # Dynamic accent color
          border-top: none;
          border-radius: 5px;
        }
        .notification-default-action:hover,
        .notification-action:hover {
          color: ${currentTheme.highlight};  # Success color on hover
          background: ${currentTheme.highlight};  # Success color background on hover
        }
        .inline-reply {
          margin-top: 8px;
        }
        .inline-reply-entry {
          background: ${currentTheme.bg};  # Dynamic background color
          color: ${currentTheme.fg};  # Dynamic foreground text color
          caret-color: ${currentTheme.fg};
          border: 1px solid ${currentTheme.warning};  # Dynamic accent color
          border-radius: 5px;
        }
        .inline-reply-button {
          margin-left: 4px;
          background: ${currentTheme.bg};  # Dynamic background color
          border: 1px solid ${currentTheme.warning};  # Dynamic accent color
          border-radius: 5px;
          color: ${currentTheme.fg};  # Dynamic foreground text color
        }
        .widget-title {
          color: ${currentTheme.highlight};  # Dynamic accent color
          background: ${currentTheme.bg};  # Dynamic background color
          padding: 5px 10px;
          margin: 10px 10px 5px 10px;
          font-size: 1.5rem;
          border-radius: 5px;
        }
        .widget-dnd {
          background: ${currentTheme.bg};  # Dynamic background color
          padding: 5px 10px;
          margin: 10px 10px 5px 10px;
          border-radius: 5px;
          font-size: large;
          color: ${currentTheme.highlight};  # Dynamic accent color
        }
        .widget-volume {
          background: ${currentTheme.secondaryBg};  # Secondary background
          padding: 5px;
          margin: 10px 10px 5px 10px;
          border-radius: 5px;
          font-size: x-large;
          color: ${currentTheme.fg};  # Primary text color
        }
    '';
  };
}
