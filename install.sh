#!/usr/bin/env bash

REPO_URL="https://github.com/thegenem0/solnix"

if [ "$(grep -i nixos </etc/os-release)" != "" ]; then
  echo "Verified this is NixOS."
else
  echo "Installation is only supported on NixOS."
  exit
fi

if command -v git &>/dev/null; then
  echo "Git is installed, continuing with installation."
else
  echo "Git is not installed. Please install Git and try again."
  echo "Example: nix-shell -p git"
  exit
fi

if command -v python3 &>/dev/null; then
  echo "Python 3 is installed, continuing with installation."
else
  echo "Python 3 is not installed. Please install Python 3 and try again."
  echo "Example: nix-shell -p python3"
  exit
fi

echo "Ensure In Home Directory"
cd || exit

backupname=$(date "+%Y-%m-%d-%H-%M-%S")
if [ -d "solnix" ]; then
  echo "SolNix exists, backing up to .config/solnix-backups/$backupname"
  if [ -d ".config/solnix-backups" ]; then
    echo "Moving current version of SolNix to backups folder at .config/solnix-backups/$backupname."
    mv "$HOME"/solnix .config/solnix-backups/"$backupname"
    sleep 1
  else
    echo "Creating the backups folder & moving SolNix to it at .config/solnix-backups/$backupname."
    mkdir -p .config/solnix-backups
    mv "$HOME"/solnix .config/solnix-backups/"$backupname"
    sleep 1
  fi
else
  echo "Nothing to backup, moving on."
fi

echo "Cloning & Entering SolNix Repository"
git clone "$REPO_URL"
cd solnix || exit

chmod +x installer/install.py
python3 installer/install.py
