{ pkgs, username, ... }:

pkgs.writeShellScriptBin "init-devflake" ''
  current_dir_name=$(basename "$PWD")

  template_file="/home/${username}/.config/templates/devflake.nix"
  destination_file="$PWD/flake.nix"

  if [ ! -f "$template_file" ]; then
    echo "Template file not found at $template_file"
    exit 1
  fi

  cp "$template_file" "$destination_file"

  sed -i "s/description = \"default\";/description = \"$current_dir_name\";/" "$destination_file"

  chmod 644 "$destination_file"

  echo "Initialized flake.nix with description \"$current_dir_name\""
  echo "Run \"nix develop\" to enter the dev shell"
  echo "MAKE SURE TO HAVE THE \"flake.nix\" FILE STAGED IF IN A GIT REPO"
''
