{ pkgs, host, inputs, lib, ... }:
let
  inherit (import ../hosts/${host}/variables.nix) systemTheme;
  spicetifyPkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicetifyPkgs.extensions; [
      adblock
      hidePodcasts
      shuffle
    ];
    theme = if systemTheme.name == "catppuccin" then
      lib.mkDefault spicetifyPkgs.themes.catppuccin
    else if systemTheme.name == "dracula" then
      lib.mkDefault spicetifyPkgs.themes.dracula
    else
      lib.mkDefault spicetifyPkgs.themes.nord;

    colorScheme = lib.mkIf (systemTheme.name == "catppuccin")
      (if systemTheme.variant == "latte" then
        lib.mkDefault "latte"
      else if systemTheme.variant == "frappe" then
        lib.mkDefault "frappe"
      else if systemTheme.variant == "macchiato" then
        lib.mkDefault "macchiato"
      else if systemTheme.variant == "mocha" then
        lib.mkDefault "mocha"
      else
        throw "Unknown catppuccin variant: ${systemTheme.variant}");
  };
}
