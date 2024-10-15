{
  programs.fastfetch = {
    enable = true;

    settings = {
      display = {
        separator = " ==> ";
        };

      logo = {
        type = "auto";
      };

      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "wm"
        "terminal"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "localip"
        "break"
      ];
    };
  };
}
