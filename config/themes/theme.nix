{ config, ... }:

let
  draculaDefault = import ./dracula.nix { flavor = "default"; };
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
      else if themeVariant == "mocha" then cattpuccinMocha
      else throw "Unknown Catppuccin variant: ${themeVariant}"
    else if themeName == "stylix" then
      if themeVariant == "default" then {
        bg = "#${stylixTheme.base00}";
        secondaryBg = "#${stylixTheme.base01}";
        selectionBg = "#${stylixTheme.base02}";
        inactiveFg = "#${stylixTheme.base03}";
        subtleFg = "#${stylixTheme.base04}";
        fg = "#${stylixTheme.base05}";
        highlightFg = "#${stylixTheme.base06}";
        brightFg = "#${stylixTheme.base07}";
        error = "#${stylixTheme.base08}";
        warning = "#${stylixTheme.base09}";
        highlight = "#${stylixTheme.base0A}";
        success = "#${stylixTheme.base0B}";
        info = "#${stylixTheme.base0C}";
        accent = "#${stylixTheme.base0D}";
        special = "#${stylixTheme.base0E}";
        extra = "#${stylixTheme.base0F}";
      }
      else throw "Unknown Stylix variant: ${themeVariant}"
    else throw "Unknown theme: ${themeName}";
in
  {
    inherit getTheme;
  }

