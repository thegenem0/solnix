{
  # Hyprland Settings
  extraMonitorSettings = "";

  # Waybar Settings
  clock24h = true;

  systemTheme = {
    name = "dracula";
    variant = "default";
  };

  amd = {
    enable = false;
  };
  nvidia = {
    enable = false;
    prime = {
      intelBusID = "";
      nvidiaBusID = "";
    };
  };
  intel = {
    enable = true;
  };

  # Program Options
  browser = "firefox";
  terminal = "kitty";
  keyboardLayout = "us";
}
