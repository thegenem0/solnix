{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
          separator = " ==> ";
        };
      logo = {
        source = ../misc/logo.png;
        type = "kitty-direct";
        height = 16;
        width = 32;
      };
      modules = [
        {
            type = "custom";
            format = "┌───────────────────── Hardware ─────────────────────┐";
        }
        {
            type = "cpu";
            key = "│  ";
        }
        {
            type = "gpu";
            key = "│ 󰍛 ";
        }
        {
            type = "memory";
            key = "│ 󰑭 ";
        }
        {
          type = "disk";
          key = "│ 󰋊 ";
        }
        {
          type = "localip";
          key = "│ 󰌈 ";
        }
        {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
        }
        {
            type = "custom";
            format = "┌────────────────────── System ──────────────────────┐";
        }
        {
            type = "kernel";
            key = "│  ";
        }
        {
            type = "packages";
            key = "│ 󰏖 ";
        }
        {
            type = "shell";
            key = "│  ";
        }
        {
            type = "wm";
            key = "│  WM";
        }
        {
            type = "wmtheme";
            key = "│ 󰉼 ";
        }
        {
            type = "terminal";
            key = "│  ";
        }
        {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
        }
      ];
    #   modules = [
    #     "title"
    #     "separator"
    #     "os"
    #     "host"
    #     "kernel"
    #     "uptime"
    #     "packages"
    #     "shell"
    #     "wm"
    #     "terminal"
    #     "cpu"
    #     "gpu"
    #     "memory"
    #     "disk"
    #     "localip"
    #     "break"
    #   ];
    };
  };
}
