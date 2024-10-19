{ config, ... }:

let
  draculaDefault = import ./dracula.nix { flavor = "default"; };
  catppuccinMocha = import ./catppuccin.nix { flavor = "mocha"; };
  catppuccinLatte = import ./catppuccin.nix { flavor = "latte"; };
  catppuccinFrappe = import ./catppuccin.nix { flavor = "frappe"; };
  catppuccinMacchiato = import ./catppuccin.nix { flavor = "macchiato"; };
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
    else if themeName == "catppuccin" then
      if themeVariant == "latte" then catppuccinLatte
      else if themeVariant == "frappe" then catppuccinFrappe
      else if themeVariant == "macchiato" then catppuccinMacchiato
      else if themeVariant == "mocha" then catppuccinMocha
      else throw "Unknown Catppuccin variant: ${themeVariant}"
    else if themeName == "stylix" then {
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
    else throw "Unknown theme: ${themeName}";
in
  {
    inherit getTheme;
  }

