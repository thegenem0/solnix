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
    * {
      background-color: ${currentTheme.bg};
      background: rgba(0,0,0,0.7);
      foreground: ${currentTheme.fg};
      border-color:  ${currentTheme.accent};
      text-color:  ${currentTheme.info};
    }
    /* ---- Configuration ---- */
    configuration {
        modi:                       "drun,run";
        font:                       "JetBrains Mono Nerd Font 12";
        show-icons:                 true;
        hover-select:               false;
        me-select-entry:            "";
        me-accept-entry:            "MousePrimary";
        drun-display-format:        "{name}";
        window-format:              "{w} · {c} · {t}";
        scroll-method: 1;
    }

    /* ---- Window ---- */
    window {
        width:                        761px;
        x-offset:                     0px;
        y-offset:                     65px;
        spacing:                      0px;
        padding:                      0px;
        margin:                       0px;
        color:                        var(background-color);
        border:                       2px;
        border-color:                 var(border-color);
        cursor:                       "default";
        transparency:                 "real";
        location:                     north;
        anchor:                       north;
        fullscreen:                   false;
        enabled:                      true;
        border-radius:                10px;
        background-color:             transparent;
    }

    /* ---- Mainbox ---- */
    mainbox {
        enabled:                      true;
        orientation:                  horizontal;
        spacing:                      0px;
        margin:                       0px;
        background-color:             @background;
        children:                     ["listbox"];
    }

    /* ---- Imagebox ---- */
    imagebox {
        padding:                      18px;
        background-color:             transparent;
        orientation:                  vertical;
        children:                     [ "inputbar", "dummy", "mode-switcher" ];
    }

    /* ---- Listbox ---- */
    listbox {
        spacing:                     20px;
        background-color:            transparent;
        orientation:                 vertical;
        children:                    [ "inputbar", "message", "listview" ];
    }

    /* ---- Dummy ---- */
    dummy {
        background-color:            transparent;
    }

    /* ---- Inputbar ---- */
    inputbar {
        enabled:                      true;
        text-color:                   @foreground;
        spacing:                      10px;
        padding:                      15px;
        border-radius:                0px;
        border-color:                 @foreground;
        background-color:             @background;
        children:                     [ "textbox-prompt-colon", "entry" ];
    }

    textbox-prompt-colon {
        enabled:                      true;
        expand:                       false;
        padding:                      0px 5px 0px 0px;
        str:                          "";
        background-color:             transparent;
        text-color:                   inherit;
    }

    entry {
        enabled:                      true;
        background-color:             transparent;
        text-color:                   inherit;
        cursor:                       text;
        placeholder:                  "Search";
        placeholder-color:            inherit;
    }

    /* ---- Mode Switcher ---- */
    mode-switcher{
        enabled:                      true;
        spacing:                      20px;
        background-color:             transparent;
        text-color:                   @foreground;
    }

    button {
        padding:                      10px;
        border-radius:                10px;
        background-color:             @background;
        text-color:                   inherit;
        cursor:                       pointer;
        border:                       0px;
    }

    button selected {
        background-color:             @foreground;
        text-color:                   @foreground;
    }

    /* ---- Listview ---- */
    listview {
        enabled:                      true;
        columns:                      6;
        lines:                        3;
        cycle:                        false;
        dynamic:                      false;
        scrollbar:                    true;
        layout:                       vertical;
        reverse:                      false;
        spacing:                      10px;
        padding:                      10px;
        margin:                       0px;
        fixed-height:                 true;
        fixed-columns:                true;
        background-color:             @background;
        border:                       0px;
        flow:                         horizontal;
    }

    /* ---- Element ---- */
    element {
        enabled:                      true;
        padding:                      0px;
        margin:                       5px;
        cursor:                       pointer;
        background-color:             @background;
        border-radius:                10px;
        border:                       2px;
        orientation:                  vertical;
    }

    element normal.normal {
        border-color:                @border-color;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element normal.urgent {
        border-color:                @border-color;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element normal.active {
        border-color:                @border-color;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element selected.normal {
        border-color:                @foreground;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element selected.urgent {
        border-color:                @foreground;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element selected.active {
        border-color:                @foreground;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element alternate.normal {
        border-color:                @border-color;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element alternate.urgent {
        border-color:                @border-color;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element alternate.active {
        border-color:                @border-color;
        background-color:            inherit;
        text-color:                  @foreground;
    }

    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        100px;
        cursor:                      inherit;
        horizontal-align:              0.5;
    }

    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.1;
        enabled: false;
    }

    /*****----- Message -----*****/
    message {
        background-color:            transparent;
        border:0px;
        margin:20px 0px 0px 0px;
        padding:0px;
        spacing:0px;
        border-radius: 10px;
    }

    textbox {
        padding:                     15px;
        margin:                      0px;
        border-radius:               0px;
        background-color:            @background;
        text-color:                  @foreground;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    error-message {
        padding:                     15px;
        border-radius:               20px;
        background-color:            @background;
        text-color:                  @foreground;
    }
  '';
}
