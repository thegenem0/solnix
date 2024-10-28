{
  pkgs,
  config,
  host,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix) systemTheme;
  inherit (import ../themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
in
{
  programs = {
    rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      extraConfig = {
        modi = "drun";
        show-icons = true;
        icon-theme = "Papirus";
        location = 0;
        font = "JetBrainsMono Nerd Font Mono 12";
        display-drun = " ";
        drun-display-format = "{name}";
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = mkLiteral "${currentTheme.bg}";
            bg-alt = mkLiteral "${currentTheme.fg}";
            foreground = mkLiteral "${currentTheme.fg}";
            selected = mkLiteral "${currentTheme.info}";
            active = mkLiteral "${currentTheme.success}";
            text-selected = mkLiteral "${currentTheme.bg}";
            text-color = mkLiteral "${currentTheme.info}";
            border-color = mkLiteral "${currentTheme.fg}";
            urgent = mkLiteral "${currentTheme.warning}";
          };
          "window" = {
            enabled = true;
            transparency = "real";
            location = mkLiteral "center";
            anchor = mkLiteral "center";
            fullscreen = mkLiteral "false";
            width = mkLiteral "700px";
            x-offset = mkLiteral "0px";
            y-offset = mkLiteral "0px";
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            border = mkLiteral "2px";
            border-color = "@border-color";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "@bg";
            cursor = mkLiteral "default";
          };
          "mainbox" = {
            enabled = true;
            spacing = mkLiteral "10px";
            margin = mkLiteral "0px";
            padding = mkLiteral "20px";
            border-color = mkLiteral "@selected";
            background-color = mkLiteral "transparent";
            children = map mkLiteral [
              "inputbar"
              "listview"
            ];
          };
          "inputbar" = {
            enabled = true;
            spacing = mkLiteral "10px";
            margin = mkLiteral "0px";
            padding = mkLiteral "15px";
            border = mkLiteral "2px solid";
            border-color = mkLiteral "@selected";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@foreground";
            children = map mkLiteral [
              "prompt"
              "entry"
            ];
          };
          "prompt" = {
            enabled = true;
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          "textbox-prompt-colon" = {
            enabled = true;
            expand = false;
            str = "::";
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          "entry" = {
            enabled = true;
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "text";
            placeholder = "Search...";
            placeholder-color = mkLiteral "inherit";
          };
          "listview" = {
            enabled = true;
            columns = 2;
            lines = 8;
            cycle = true;
            dynamic = true;
            scrollbar = false;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = true;
            fixed-columns = true;

            spacing = mkLiteral "5px";
            margin = mkLiteral "0px";
            padding = mkLiteral "0px";
            border = mkLiteral "0px";
            border-color = mkLiteral "@selected";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
            cursor= mkLiteral "default";
          };
          "scrollbar" = {
            handle-color = mkLiteral "@selected";
            border-radius = mkLiteral "10px";
            handle-width = mkLiteral "10px";
            background-color = mkLiteral "@bg-alt";
          };
          "element" = {
            enabled = true;
            spacing = mkLiteral "10px";
            margin = mkLiteral "0px";
            padding = mkLiteral "5px";
            border = mkLiteral "0px";
            border-radius = mkLiteral "12px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@foreground";
            cursor = mkLiteral "pointer";
          };
          "element normal.normal" = {
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@foreground";
          };
          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@bg";
          };
          "element-icon" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            size = mkLiteral "32px";
            cursor = mkLiteral "inherit";
          };
          "element-text" = {
            background-color = mkLiteral "transparent";
            font = "JetBrainsMono Nerd Font Mono 12";
            text-color = mkLiteral "inherit";
            highlight = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
          "error-message" = {
            padding = mkLiteral "15px";
            border = mkLiteral "2px solid";
            border-radius = mkLiteral "12px";
            border-color = mkLiteral "@selected";
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@foreground";
          };
          "textbox" = {
            background-color = mkLiteral "@bg";
            text-color = mkLiteral "@foreground";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
            highlight = mkLiteral "none";
          };
        };
    };
  };
}
