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
  inherit (import ../themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
  zshPlugins = [
    "reegnz/aws-vault-zsh-plugin"
    "lukechilds/zsh-nvm"
    "aloxaf/fzf-tab"
    "zsh-users/zsh-syntax-highlighting"
    "MichaelAquilina/zsh-auto-notify"
    "unixorn/autoupdate-antigen.zshplugin"
    "reegnz/jq-zsh-plugin"
    "aubreypwd/zsh-plugin-reload"
    "qoomon/zsh-lazyload"
  ];
in
{
  home.file.".zshrc".source = ./zshrc;
  home.file.".scripts".source = ./scripts;
  home.file.".config/templates".source = ../misc/templates;

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

        foreground = "${currentTheme.fg}";
        background = "${currentTheme.bg}";
        cursor = "${currentTheme.fg}";

        active_tab_foreground = "${currentTheme.bg}";
        active_tab_background = "${currentTheme.fg}";
        inactive_tab_foreground = "${currentTheme.fg}";
        inactive_tab_background = "${currentTheme.bg}";

        active_border_color = "${currentTheme.fg}";
        inactive_border_color = "${currentTheme.bg}";
        bell_border_color = "${currentTheme.special}";

        color0 = "${currentTheme.bg}";
        color8 = "${currentTheme.inactiveFg}";
        color1 = "${currentTheme.error}";
        color9 = "${currentTheme.error}";
        color2 = "${currentTheme.success}";
        color10 = "${currentTheme.success}";
        color3 = "${currentTheme.highlight}";
        color11 = "${currentTheme.highlight}";
        color4 = "${currentTheme.accent}";
        color12 = "${currentTheme.accent}";
        color5 = "${currentTheme.special}";
        color13 = "${currentTheme.special}";
        color6 = "${currentTheme.info}";
        color14 = "${currentTheme.info}";
        color7 = "${currentTheme.fg}";
        color15 = "${currentTheme.brightFg}";
      };
    };
    zsh = {
      enable = true;
      package = pkgs.zsh;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      initExtra = ''
        # Initialize Antidote
        source "${pkgs.antidote}/share/antidote/antidote.zsh"
        antidote load ${builtins.concatStringsSep " " zshPlugins}
      '';
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
      extraConfig = ''
        set-option -sa terminal-overrides ',xterm*:Tc'
        set -g mouse on
        set -g base-index 1
        set -g pane-base-index 1
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on
        set -g @dracula-plugins "git cpu-usage ram-usage"
        unbind-key C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi 'y' send-keys -X copy-selection
        bind '"' split-window -v -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"
      '';
      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.yank
        tmuxPlugins.tmux-fzf
        tmuxPlugins.dracula
      ];
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
        add_newline = true;
        line_break = {
          disabled = true;
        };
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
