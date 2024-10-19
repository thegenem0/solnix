{ flavor }:

let
  catppuccinLatte = {
    bg = "#eff1f5";                 # base00 (base)
    secondaryBg = "#e6e9ef";        # base01 (mantle)
    selectionBg = "#ccd0da";        # base02 (surface0)
    inactiveFg = "#bcc0cc";         # base03 (surface1)
    subtleFg = "#acb0be";           # base04 (surface2)
    fg = "#4c4f69";                 # base05 (text)
    highlightFg = "#dc8a78";        # base06 (rosewater)
    brightFg = "#7287fd";           # base07 (lavender)
    error = "#d20f39";              # base08 (red)
    warning = "#fe640b";            # base09 (peach)
    highlight = "#df8e1d";          # base0A (yellow)
    success = "#40a02b";            # base0B (green)
    info = "#179299";               # base0C (teal)
    accent = "#1e66f5";             # base0D (blue)
    special = "#8839ef";            # base0E (mauve)
    extra = "#dd7878";              # base0F (flamingo)
  };
  catppuccinFrappe = {
    bg = "#303446";                 # base00 (base)
    secondaryBg = "#292c3c";        # base01 (mantle)
    selectionBg = "#414559";        # base02 (surface0)
    inactiveFg = "#51576d";         # base03 (surface1)
    subtleFg = "#626880";           # base04 (surface2)
    fg = "#c6d0f5";                 # base05 (text)
    highlightFg = "#f2d5cf";        # base06 (rosewater)
    brightFg = "#babbf1";           # base07 (lavender)
    error = "#e78284";              # base08 (red)
    warning = "#ef9f76";            # base09 (peach)
    highlight = "#e5c890";          # base0A (yellow)
    success = "#a6d189";            # base0B (green)
    info = "#81c8be";               # base0C (teal)
    accent = "#8caaee";             # base0D (blue)
    special = "#ca9ee6";            # base0E (mauve)
    extra = "#eebebe";              # base0F (flamingo)
  };
  catppuccinMacchiato = {
    bg = "#24273a";                 # base00 (base)
    secondaryBg = "#1e2030";        # base01 (mantle)
    selectionBg = "#363a4f";        # base02 (surface0)
    inactiveFg = "#494d64";         # base03 (surface1)
    subtleFg = "#5b6078";           # base04 (surface2)
    fg = "#cad3f5";                 # base05 (text)
    highlightFg = "#f4dbd6";        # base06 (rosewater)
    brightFg = "#b7bdf8";           # base07 (lavender)
    error = "#ed8796";              # base08 (red)
    warning = "#f5a97f";            # base09 (peach)
    highlight = "#eed49f";          # base0A (yellow)
    success = "#a6da95";            # base0B (green)
    info = "#8bd5ca";               # base0C (teal)
    accent = "#8aadf4";             # base0D (blue)
    special = "#c6a0f6";            # base0E (mauve)
    extra = "#f0c6c6";              # base0F (flamingo)
  };
  catppuccinMocha = {
    bg = "#1e1e2e";                 # base00 (base)
    secondaryBg = "#181825";        # base01 (mantle)
    selectionBg = "#313244";        # base02 (surface0)
    inactiveFg = "#45475a";         # base03 (surface1)
    subtleFg = "#585b70";           # base04 (surface2)
    fg = "#cdd6f4";                 # base05 (text)
    highlightFg = "#f5e0dc";        # base06 (rosewater)
    brightFg = "#b4befe";           # base07 (lavender)
    error = "#f38ba8";              # base08 (red)
    warning = "#fab387";            # base09 (peach)
    highlight = "#f9e2af";          # base0A (yellow)
    success = "#a6e3a1";            # base0B (green)
    info = "#94e2d5";               # base0C (teal)
    accent = "#89b4fa";             # base0D (blue)
    special = "#cba6f7";            # base0E (mauve)
    extra = "#f2cdcd";              # base0F (flamingo)
  };
in
  if flavor == "latte" then catppuccinLatte
  else if flavor == "frappe" then catppuccinFrappe
  else if flavor == "macchiato" then catppuccinMacchiato
  else if flavor == "mocha" then catppuccinMocha
  else throw "Unknown flavor: ${flavor}"

