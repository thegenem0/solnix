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
  home.file.".config/rofi/wallselect.rasi".text = ''
    /* ---- Global Settings ---- */
    * {
      background-color: ${currentTheme.bg};
      background: rgba(0,0,0,0.7);
      foreground: ${currentTheme.fg};
      border-color: ${currentTheme.accent};
      text-color: ${currentTheme.info};
    }

    /* ---- Configuration ---- */
    configuration {
        font: "JetBrains Mono Nerd Font 12";
        show-icons: true;
        hover-select: false;
        scroll-method: 1;
    }

    /* ---- Window ---- */
    window {
        width: 761px;
        x-offset: 0px;
        y-offset: 65px;
        padding: 0px;
        margin: 0px;
        border: 2px;
        border-color: var(border-color);
        border-radius: 10px;
        location: north;
        anchor: north;
        background-color: transparent;
        transparency: "real";
    }

    /* ---- Mainbox ---- */
    mainbox {
        orientation: vertical;
        spacing: 0px;
        margin: 0px;
        background-color: @background;
        children: ["listview"];
    }

    /* ---- Listview ---- */
    listview {
        columns: 6;
        lines: 3;
        cycle: false;
        dynamic: false;
        scrollbar: true;
        layout: vertical;
        spacing: 10px;
        padding: 10px;
        fixed-height: true;
        fixed-columns: true;
        background-color: @background;
        border: 0px;
        flow: horizontal;
    }

    /* ---- Element ---- */
    element {
        padding: 0px;
        margin: 5px;
        cursor: pointer;
        background-color: @background;
        border-radius: 10px;
        border: 2px;
        orientation: vertical;
        border-color: @border-color;
    }

    element selected {
        border-color: @foreground;
    }

    element-icon {
        background-color: transparent;
        text-color: inherit;
        size: 100px;
        cursor: inherit;
        horizontal-align: 0.5;
    }

    element-text {
        enabled: false;
    }
  '';
}
