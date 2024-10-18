{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
          separator = " ==> ";
        };
      logo = {
        source = ../logo.png;
        type = "kitty-direct";
        height = 15;
        width = 30;
      };
      modules = [
        "break"
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
        "break"
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
        "break"
        {
            type = "custom";
            format = "┌─────────────────── Uptime / Age ───────────────────┐";
        }
        {
            type = "command";
            key = "│  ";
            text = #bash
            ''
              birth_install=$(stat -c %W /)
              current=$(date +%s)
              delta=$((current - birth_install))
              delta_days=$((delta / 86400))
              echo $delta_days days
            '';
        }
        {
            type = "uptime";
            key = "│  ";
        }
        {
            type = "custom";
            format = "└────────────────────────────────────────────────────┘";
        }
        "break"
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
