{
  pkgs,
  host,
  inputs,
  lib,
  ...
}:
let
  inherit (import ../hosts/${host}/variables.nix) systemTheme;
  spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicetifyPkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    theme = if systemTheme.name == "catppuccin" then
              spicetifyPkgs.themes.catppuccin
            else if systemTheme.name == "dracula" then
                spicetifyPkgs.themes.dracula
            else spicetifyPkgs.themes.nord;

    colorScheme = lib.mkIf (systemTheme.name == "catppuccin") (
      if systemTheme.variant == "latte" then
        "latte"
      else if systemTheme.variant == "frappe" then
        "frappe"
      else if systemTheme.variant == "macchiato" then
        "macchiato"
      else if systemTheme.variant == "mocha" then
        "mocha"
      else
        throw "Unknown catppuccin variant: ${systemTheme.variant}"
    );
  };
}
