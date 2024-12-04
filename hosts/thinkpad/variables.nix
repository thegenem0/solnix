{
  clock24h = true;
  systemTheme = {
    name = "catppuccin";
    variant = "mocha";
  };
  amd = { enable = false; };
  nvidia = {
    enable = false;
    prime = {
        enable = false;
        intelBusID = "";
        nvidiaBusID = "";
      };
  };
  intel = { enable = true; };
  keyboardLayout = "us";
  primaryMonitor = "eDP-1";
  browser = "firefox";
  terminal = "kitty";
}
