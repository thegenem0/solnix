{ flavor }:
let
  draculaDefault = {
    bg = "#282936";                 # base00 (background)
    secondaryBg = "#3a3c4e";        # base01
    selectionBg = "#4d4f68";        # base02
    inactiveFg = "#626483";         # base03
    subtleFg = "#62d6e8";           # base04
    fg = "#e9e9f4";                 # base05 (foreground)
    highlightFg = "#f1f2f8";        # base06
    brightFg = "#f7f7fb";           # base07
    error = "#ea51b2";              # base08 (red equivalent)
    warning = "#b45bcf";            # base09 (purple equivalent)
    highlight = "#00f769";          # base0A (yellow equivalent)
    success = "#ebff87";            # base0B (green equivalent)
    info = "#a1efe4";               # base0C (cyan equivalent)
    accent = "#62d6e8";             # base0D (blue equivalent)
    special = "#b45bcf";            # base0E (purple equivalent)
    extra = "#00f769";              # base0F (green equivalent)
  };
in
  if flavor == "default" then draculaDefault
  else draculaDefault
