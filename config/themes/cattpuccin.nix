{ flavor }:

let
  cattpuccinLatte = {
    background = "#eff1f5";
    foreground = "#4c4f69";
    comment = "#8c8fa1";
    cyan = "#04a5e5";
    green = "#40a02b";
    orange = "#fe640b";
    pink = "#ea76cb";
    purple = "#8839ef";
    red = "#d20f39";
    yellow = "#df8e1d";
  };

  cattpuccinFrappe = {
    background = "#303446";
    foreground = "#c6d0f5";
    comment = "#838ba7";
    cyan = "#99d1db";
    green = "#a6d189";
    orange = "#ef9f76";
    pink = "#f4b8e4";
    purple = "#ca9ee6";
    red = "#e78284";
    yellow = "#e5c890";
  };

  cattpuccinMacchiato = {
    background = "#24273a";
    foreground = "#cad3f5";
    comment = "#8087a2";
    cyan = "#91d7e3";
    green = "#a6da95";
    orange = "#f5a97f";
    pink = "#f5bde6";
    purple = "#c6a0f6";
    red = "#ed8796";
    yellow = "#eed49f";
  };

  cattpuccinMocha = {
    background = "#1e1e2e";
    foreground = "#cdd6f4";
    comment = "#7f849c";
    cyan = "#89dceb";
    green = "#a6e3a1";
    orange = "#f9e2af";
    pink = "#f5c2e7";
    purple = "#cba6f7";
    red = "#f38ba8";
    yellow = "#f9e2af";
  };
in
  if flavor == "latte" then cattpuccinLatte
  else if flavor == "frappe" then cattpuccinFrappe
  else if flavor == "macchiato" then cattpuccinMacchiato
  else cattpuccinMocha

