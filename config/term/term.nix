{ inputs, pkgs, host, lib, config, ... }:
let
  inherit (import ../../hosts/${host}/variables.nix) systemTheme;
  inherit (import ../themes/theme.nix { inherit config; }) getTheme;
  currentTheme = getTheme systemTheme;
in {
  home.file = {
    ".scripts".source = ./scripts;
    ".ideavimrc".source = ../misc/ideavimrc;
  };

  home.packages =
    [ pkgs.antidote inputs.solnix-vim.packages.${pkgs.stdenv.system}.default ];

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
      antidote = {
        enable = true;
        plugins = [
          "reegnz/aws-vault-zsh-plugin"
          "lukechilds/zsh-nvm"
          "aloxaf/fzf-tab"
          "zsh-users/zsh-syntax-highlighting"
          "MichaelAquilina/zsh-auto-notify"
          "reegnz/jq-zsh-plugin"
          "aubreypwd/zsh-plugin-reload"
          "qoomon/zsh-lazyload"
        ];
      };
      initExtra = ''
        autoload -Uz compinit
        autoload -Uz edit-command-line
        zle -N edit-command-line

        compinit

        HISTSIZE=5000               #How many lines of history to keep in memory
        HISTFILE=~/.zsh_history     #Where to save history to disk
        SAVEHIST=5000               #Number of history entries to save to disk
        HISTDUP=erase               #Erase duplicates in the history file
        setopt    appendhistory     #Append history to the history file (no overwriting)
        setopt    sharehistory      #Share history across terminals
        setopt    incappendhistory  #Immediately append to the history file, not just when a term is killed

        export EDITOR="nvim"

        alias gl="lazygit"
        alias gowork="cd ~/dev/work/"
        alias gome="cd ~/dev/personal"
        alias init-devflake="nix flake init --template github:cachix/devenv"
        alias nixdev="nix develop --impure"

        alias ls='exa --icons --long --git -h --group-directories-first'
        alias l='exa -lah --icons --group-directories-first'
        alias cd='z'

        alias tf="terraform"
        alias cli-nosession="aws-vault exec hace-cli --no-session --"
        alias main-nosession="aws-vault exec hace-main --no-session --"

        alias awsvpn-connect="sudo awsvpnclient start --config ~/.vpn/hace-main.ovpn > /dev/null 2>&1 &"
        alias awsvpn-disconnect="pkill \"aws-vpn-client\""

        alias flake-rebuild="nh os switch --hostname $(hostname) /home/$(whoami)/solnix"
        alias home-rebuild="nh home switch --hostname $(hostname) /home/$(whoami)/solnix"
        alias flake-update="nh os switch --hostname $(hostname) --update /home/$(whoami)/solnix";
        alias distro-update="sh <(curl -L https://gitlab.com/solinaire/solnix/-/raw/main/install.sh)";
        alias flake-gc="nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";


        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey -s '^f' "~/.scripts/tmux-sessionizer.sh\n"
        bindkey '^w' edit-command-line
      '';
    };
    direnv = {
      enable = true;
      package = pkgs.direnv;
      enableZshIntegration = true;
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
        set -g allow-passthrough
        set-window-option -g pane-base-index 1
        set-option -g renumber-windows on
        unbind-key C-b
        set-option -g prefix C-a
        bind-key C-a send-prefix
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send-keys -X begin-selection
        bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        bind-key -T copy-mode-vi 'y' send-keys -X copy-selection
        bind '"' split-window -v -c "#{pane_current_path}"
        bind '%' split-window -h -c "#{pane_current_path}"
      '' + lib.optionalString (systemTheme.name == "catppuccin") ''
        set -g @catppuccin-palette "${systemTheme.variant}"
        set -g @catppuccin_status_left_separator " "
        set -g @catppuccin_status_right_separator " "
      '' + lib.optionalString (systemTheme.name == "dracula") ''
        set -g @dracula-plugins "git cpu-usage ram-usage"
      '' + lib.optionalString (systemTheme.name == "stylix") "";

      plugins = with pkgs; [
        tmuxPlugins.sensible
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.yank
        tmuxPlugins.tmux-fzf
        (if systemTheme.name == "catppuccin" then
          tmuxPlugins.catppuccin
        else if systemTheme.name == "dracula" then
          tmuxPlugins.dracula
        else
          tmuxPlugins.nord)
      ];
    };
    zoxide = {
      enable = true;
      package = pkgs.zoxide;
      enableZshIntegration = true;
    };
    yazi = {
      enable = true;
      package = pkgs.yazi;
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
        line_break = { disabled = true; };
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
        directory = {
          read_only = "ro";
          read_only_style = "bold red";
          style = "bold blue";
          format =
            "[](bold blue) [$path]($style) [$read_only]($read_only_style)";
        };
        git_commit = { tag_symbol = "[ ](bold green)"; };
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
          format = "[$symbol nix](bold blue) ";
        };
        aws = {
          symbol = "";
          format = "[$symbol $profile]($style) ";
          style = "bold yellow";
          profile_aliases = {
            "Enterprise_Naming_Scheme-voidstars" = "void**";
          };
        };
        gcloud = {
          symbol = "󱇶";
          format = "[$symbol $account]($style) ";
          style = "bold blue";
        };
        c = {
          symbol = "";
          format = "[$symbol ($version(-$name))]($style) ";
          detect_files = [ "*.c" "*.h" ];
        };
        cmake = {
          symbol = "";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "CMakeLists.txt" "*.cmake" ];
        };
        dotnet = {
          symbol = "󰪮";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "*.csproj" "*.sln" ];
        };
        docker_context = {
          symbol = "";
          format = "[$symbol $context]($style) ";
          style = "blue bold";
          only_with_files = true;
          detect_files =
            [ "docker-compose.yml" "docker-compose.yaml" "Dockerfile" ];
        };
        git_branch = { symbol = ""; };
        golang = {
          symbol = "";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "*.go" ];
        };
        java = {
          symbol = "";
          format = "[$symbol]($style) ";
          detect_files = [ "*.java" "pom.xml" ];
        };
        kotlin = {
          symbol = "";
          format = "[$symbol]($style) ";
          detect_files = [ "*.kt" "*.kts" ];
        };
        scala = {
          symbol = "";
          format = "[$symbol]($style) ";
          detect_files = [ "*.scala" ];
        };
        gradle = {
          symbol = "";
          format = "[$symbol]($style) ";
          detect_files = [ "build.gradle" "settings.gradle" ];
        };
        lua = {
          symbol = "";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "*.lua" ];
        };
        nodejs = {
          symbol = "";
          format = "[$symbol ($version)](bold green) ";
          detect_files = [ "package.json" ".node-version" ];
          detect_folders = [ "node_modules" ];
        };
        memory_usage = { symbol = " "; };
        os = { symbols = { NixOS = " "; }; };
        package = { symbol = "pkg "; };
        python = {
          symbol = "";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "*.py" "requirements.txt" "Pipfile" ];
        };
        conda = {
          symbol = "";
          format = "[$symbol $environment](dimmed green) ";
        };
        rust = {
          symbol = "";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "Cargo.toml" ];
        };
        sudo = { symbol = "sudo "; };
        terraform = {
          symbol = "󱁢";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "*.tf" ];
        };
        zig = {
          symbol = "";
          format = "[$symbol ($version)]($style) ";
          detect_files = [ "*.zig" ];
        };
      };
    };
  };
}
