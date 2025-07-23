{
  clock24h = true;
  systemTheme = {
    name = "catppuccin";
    variant = "mocha";
  };
  amd = { enable = true; };
  nvidia = {
    enable = false;
    prime = {
      enable = false;
      intelBusID = "";
      nvidiaBusID = "";
    };
  };
  intel = { enable = false; };
  keyboardLayout = "us";
  primaryMonitor = "eDP-1";
  browser = "firefox";
  terminal = "kitty";
  containerizationPlatform = "docker";
}
