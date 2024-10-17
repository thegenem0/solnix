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
        show-icons = false;
        icon-theme = "Papirus";
        location = 0;
        font = "JetBrainsMono Nerd Font Mono 12";
        display-drun = " Apps";
        drun-display-format = "{name} [<span weight='light' size='small'><i>({generic})</i></span>]";
        window-format = "{w} · {c} · {t}";
      };
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          "*" = {
            bg = mkLiteral "${currentTheme.bg}";
            bg-alt = mkLiteral "${currentTheme.warning}";
            foreground = mkLiteral "${currentTheme.fg}";
            selected = mkLiteral "${currentTheme.error}";
            active = mkLiteral "${currentTheme.success}";
            text-selected = mkLiteral "${currentTheme.bg}";
            text-color = mkLiteral "${currentTheme.fg}";
            border-color = mkLiteral "${currentTheme.special}";
            urgent = mkLiteral "${currentTheme.special}";
          };
          "window" = {
            width = mkLiteral "50%";
            transparency = "real";
            orientation = mkLiteral "vertical";
            cursor = mkLiteral "default";
            spacing = mkLiteral "0px";
            border = mkLiteral "2px";
            border-color = "@border-color";
            border-radius = mkLiteral "20px";
            background-color = mkLiteral "@bg";
          };
          "mainbox" = {
            enabled = true;
            spacing = mkLiteral "20px";
            padding = mkLiteral "40px";
            border-color = mkLiteral "@border-color";
            background-color = mkLiteral "transparent";
            children = map mkLiteral [
              "inputbar",
              "message",
              "listview",
            ];
          };
          "inputbar" = {
            enabled = true;
            spacing = mkLiteral "10px";
            margin = mkLiteral "10px";
            border-color = mkLiteral "@border-color";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@text-color";
            children = map mkLiteral [
              "prompt"
              "textbox-prompt-colon"
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
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@text-selected";
            cursor = mkLiteral "text";
            placeholder = "Search...";
            placeholder-color = mkLiteral "inherit";
          };
          "listview" = {
            enabled = true;
            columns = 2;
            lines = 6;
            cycle = true;
            dynamic = true;
            scrollbar = true;
            layout = mkLiteral "vertical";
            reverse = false;
            fixed-height = true;
            fixed-columns = true;
            spacing = mkLiteral "10px";
            border-color = mkLiteral "@border-color";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@text-color";
            border = mkLiteral "0px";
            cursor= mkLiteral "default";
          };
          "scrollbar" = {
            handle-color = mkLiteral "@border-color";
            border-radius = mkLiteral "10px";
            handle-width = mkLiteral "10px";
            background-color = mkLiteral "@bg";
          };
          "element" = {
            enabled = true;
            spacing = mkLiteral "10px";
            padding = mkLiteral "5px 10px";
            border-radius = mkLiteral "20px";
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "@text-color";
            cursor = mkLiteral "pointer";
          };
          "element normal.normal" = {
            background-color = mkLiteral "inherit";
            text-color = mkLiteral "inherit";
          };
          "element normal.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@foreground";
          };
          "element normal.active" = {
            background-color = mkLiteral "@active";
            text-color = mkLiteral "@foreground";
          };
          "element selected.normal" = {
            background-color = mkLiteral "@selected";
            text-color = mkLiteral "@text-selected";
          };
          "element selected.urgent" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-selected";
          };
          "element selected.active" = {
            background-color = mkLiteral "@urgent";
            text-color = mkLiteral "@text-selected";
          };
          "element alternate.normal" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
          };
          "element alternate.urgent" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
          };
          "element alternate.active" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
          };
          "element-icon" = {
            background-color = mkLiteral "transparent";
            text-color = mkLiteral "inherit";
            size = mkLiteral "24px";
            cursor = mkLiteral "inherit";
          };
          "element-text" = {
            background-color = mkLiteral "transparent";
            font = "JetBrainsMono Nerd Font Mono 12";
            text-color = mkLiteral "inherit";
            cursor = mkLiteral "inherit";
            vertical-align = mkLiteral "0.5";
            horizontal-align = mkLiteral "0.0";
          };
        };
    };
  };
}
