{
  pkgs,
  lib,
  username,
  host,
  config,
  ...
}:
let
  inherit (import ../../hosts/${host}/variables.nix) systemTheme;
  inherit (import ../themes/theme.nix) getTheme;
  currentTheme = getTheme systemTheme;
in
{
  home.file.".zshrc".source = ./zshrc;
  home.file.".scripts".source = ./scripts;

  programs = {
    kitty = {
      enable = true;
      package = pkgs.kitty;
      settings = {
        font_family = "JetBrainsMono Nerd Font Mono";
        font_size = 12;
        confirm_os_window_close = 0;
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        enable_audio_bell = false;

        foreground = "${currentTheme.foreground}";
        background = "${currentTheme.background}";
        cursor = "${currentTheme.foreground}";

        active_tab_foreground = "${currentTheme.background}";
        active_tab_background = "${currentTheme.foreground}";
        inactive_tab_foreground = "${currentTheme.foreground}";
        inactive_tab_background = "${currentTheme.background}";

        active_border_color = "${currentTheme.foreground}";
        inactive_border_color = "${currentTheme.background}";
        bell_border_color = "${currentTheme.purple}";  # or any accent

        color0 = "${currentTheme.background}";    # Black
        color8 = "${currentTheme.comment}";       # Bright Black (use comment as dimmer color)
        color1 = "${currentTheme.red}";           # Red
        color9 = "${currentTheme.red}";           # Bright Red
        color2 = "${currentTheme.green}";         # Green
        color10 = "${currentTheme.green}";        # Bright Green
        color3 = "${currentTheme.yellow}";        # Yellow
        color11 = "${currentTheme.yellow}";       # Bright Yellow
        color4 = "${currentTheme.purple}";        # Purple
        color12 = "${currentTheme.purple}";       # Bright Purple
        color5 = "${currentTheme.pink}";          # Pink (Magenta equivalent)
        color13 = "${currentTheme.pink}";         # Bright Pink (Bright Magenta)
        color6 = "${currentTheme.cyan}";          # Cyan
        color14 = "${currentTheme.cyan}";         # Bright Cyan
        color7 = "${currentTheme.foreground}";    # White
        color15 = "${currentTheme.foreground}";   # Bright White
      };
    };
    zsh = {
      enable = true;
      package = pkgs.zsh;
      antidote = {
        enable = true;
        package = pkgs.antidote;
        plugins = [
          "reegnz/aws-vault-zsh-plugin"
          "lukechilds/zsh-nvm"
          "zsh-users/zsh-syntax-highlighting"
          "Aloxaf/fzf-tab"
          "MichaelAquilina/zsh-auto-notify"
          "unixorn/autoupdate-antigen.zshplugin"
          "reegnz/jq-zsh-plugin"
          "aubreypwd/zsh-plugin-reload"
          "qoomon/zsh-lazyload"
        ];
      };
      shellAliases = {
        fr = "nh os switch --hostname ${host} /home/${username}/solnix";
        fu = "nh os switch --hostname ${host} --update /home/${username}/solnix";
        zu = "sh <(curl -L https://gitlab.com/solinaire/solnix/-/raw/main/install.sh)";
        ncg = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      };

    };
    atuin = {
      enable = true;
      package = pkgs.atuin;
    };
    fzf = {
      enable = true;
      package = pkgs.fzf;
      enableZshIntegration = true;
    };
    tmux = {
      enable = true;
      package = pkgs.tmux;
    };
    zoxide = {
      enable = true;
      package = pkgs.zoxide;
      enableZshIntegration = true;
    };
    pyenv = {
      enable = true;
      package = pkgs.pyenv;
      enableZshIntegration = true;
    };
    starship = {
      enable = true;
      settings = {
        add_newline = false;
        username = {
          style_user = "green bold";
          style_root = "red bold";
          format = "[$user]($style) ";
          show_always = false;
        };
        character = {
          success_symbol = "[ ](bold green)";
          error_symbol = "[ ](bold red)";
        };
        git_commit = {
          tag_symbol = "[ ](bold green)";
        };
        git_status = {
          ahead = "";
          behind = "";
          diverged = "";
          renamed = "r";
          deleted = "";
        };
        nix_shell = {
          symbol = "";
          impure_msg = "[impure](bold red)";
          pure_msg = "[pure](bold green)";
          unknown_msg = "[unknown shell](bold yellow)";
          format = "via [$symbol nix](bold blue)";
        };
        aws = {
          symbol = " ";
          format = "(on [$symbol$profile]($style)) ";
          style = "bold yellow";
          profile_aliases = {
            "Enterprise_Naming_Scheme-voidstars" = "void**";
          };
        };
        gcloud = {
          symbol = "󱇶 ";
          format = "(on [$symbol$account]($style)) ";
          style = "bold blue";
        };
        c = {
          symbol = " ";
          format = "(via [$symbol($version(-$name) )]($style))";
          detect_files = [
            "*.c"
            "*.h"
          ];
        };
        cmake = {
          symbol = "🔧 ";
          format = "(via [$symbol($version )]($style))";
          detect_files = [
            "CMakeLists.txt"
            "*.cmake"
          ];
        };
        dotnet = {
          symbol = "󰪮 ";
          format = "(via [$symbol($version )]($style))";
          detect_files = [
            "*.csproj"
            "*.sln"
          ];
        };
        directory = {
          read_only = " ro";
          read_only_style = "bold red";
          style = "bold blue";
          format = "[  ](bold blue) [$path]($style)[$read_only]($read_only_style) ";
        };
        docker_context = {
          symbol = " ";
          format = "(via [$symbol$context]($style))";
          style = "blue bold";
          only_with_files = true;
          detect_files = [
            "docker-compose.yml"
            "docker-compose.yaml"
            "Dockerfile"
          ];
        };
        git_branch = {
          symbol = " ";
        };
        golang = {
          symbol = " ";
          format = "(via [$symbol($version )]($style))";
          detect_files = ["*.go"];
        };
        java = {
          symbol = " ";
          format = "(via [$symbol]($style))";
          detect_files = [
            "*.java"
            "pom.xml"
          ];
        };
        kotlin = {
          symbol = " ";
          format = "via [$symbol]($style)";
          detect_files = [
            "*.kt"
            "*.kts"
          ];
        };
        scala = {
          symbol = " ";
          format = "(via [$symbol]($style))";
          detect_files = ["*.scala"];
        };
        gradle = {
          symbol = " ";
          format = "(via [$symbol]($style))";
          detect_files = [
            "build.gradle"
            "settings.gradle"
          ];
        };
        lua = {
          symbol = " ";
          format = "(via [$symbol($version )]($style))";
          detect_files = ["*.lua"];
        };
        nodejs = {
          format = "(via [ Node.js ($version )](bold green))";
          detect_files = [
            "package.json"
            ".node-version"
          ];
          detect_folders = ["node_modules"];
        };
        memory_usage = {
          symbol = "  ";
        };
        os = {
          symbols = {
            NixOS = " ";
          };
        };
        package = {
          symbol = "pkg ";
        };
        python = {
          symbol = " ";
          format = "via [$symbol($version )]($style)";
          detect_files = [
            "*.py"
            "requirements.txt"
            "Pipfile"
          ];
        };
        conda = {
          symbol = " ";
          format = "[$symbol$environment](dimmed green) ";
        };
        rust = {
          symbol = " ";
          format = "(via [$symbol($version )]($style))";
          detect_files = ["Cargo.toml"];
        };
        sudo = {
          symbol = "sudo ";
        };
        terraform = {
          symbol = "󱁢 ";
          format = "(via [$symbol($version )]($style))";
          detect_files = ["*.tf"];
        };
        zig = {
          symbol = " ";
          format = "(via [$symbol($version )]($style))";
          detect_files = ["*.zig"];
        };
      };
    };
  };
}
