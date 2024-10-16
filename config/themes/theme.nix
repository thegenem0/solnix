{ ... }:

let
  draculaDefault = import ./dracula.nix; { flavor = "default"; };
  cattpuccinMocha = import ./cattpuccin.nix { flavor = "mocha"; };
  cattpuccinLatte = import ./cattpuccin.nix { flavor = "latte"; };
  cattpuccinFrappe = import ./cattpuccin.nix { flavor = "frappe"; };
  cattpuccinMacchiato = import ./cattpuccin.nix { flavor = "macchiato"; };
  stylixTheme = config.stylix.base16Scheme;

  # Function to return theme colors based on systemTheme input
  getTheme = systemTheme:
    let
      themeName = systemTheme.name;
      themeVariant = systemTheme.variant;
    in
    if themeName == "dracula" then
      if themeVariant == "default" then draculaDefault
      else throw "Unknown Dracula variant: ${themeVariant}"
    else if themeName == "cattpuccin" then
      if themeVariant == "latte" then cattpuccinLatte
      else if themeVariant == "frappe" then cattpuccinFrappe
      else if themeVariant == "macchiato" then cattpuccinMacchiato
      else throw "Unknown Catppuccin variant: ${themeVariant}"
    else if themeName == "stylix" then
      if themeVariant == "default" then {
        background = "#${stylixTheme.base00}";
        foreground = "#${stylixTheme.base05}";
        comment = "#${stylixTheme.base03}";
        cyan = "#${stylixTheme.base0C}";
        green = "#${stylixTheme.base0B}";
        orange = "#${stylixTheme.base09}";
        pink = "#${stylixTheme.base0D}";
        purple = "#${stylixTheme.base0E}";
        red = "#${stylixTheme.base08}";
        yellow = "#${stylixTheme.base0A}";
      }
      else throw "Unknown Stylix variant: ${themeVariant}"
    else throw "Unknown theme: ${themeName}";
in
  {
    inherit getTheme;
  }

