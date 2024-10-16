#!/usr/bin/env bash

if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
  echo "Verified this is NixOS."
else
  echo "Installation is only supported on NixOS."
  exit
fi

if command -v git &> /dev/null; then
  echo "Git is installed, continuing with installation."
else
  echo "Git is not installed. Please install Git and try again."
  echo "Example: nix-shell -p git"
  exit
fi

echo "Ensure In Home Directory"
cd || exit

currentHostname=$(hostname)
read -rp "Enter new hostname, or leave blank to keep current hostname: [ $currentHostname ] " hostName
if [ -z "$hostName" ]; then
  hostName=$currentHostname
fi

backupname=$(date "+%Y-%m-%d-%H-%M-%S")
if [ -d "solnix" ]; then
  echo "SolNix exists, backing up to .config/solnix-backups folder."
  if [ -d ".config/solnix-backups" ]; then
    echo "Moving current version of SolNix to backups folder."
    mv "$HOME"/solnix .config/solnix-backups/"$backupname"
    sleep 1
  else
    echo "Creating the backups folder & moving SolNix to it."
    mkdir -p .config/solnix-backups
    mv "$HOME"/solnix .config/solnix-backups/"$backupname"
    sleep 1
  fi
else
  echo "Nothing to backup, moving on."
fi

echo "Cloning & Entering SolNix Repository"
git clone https://gitlab.com/solinaire/solnix.git
cd solnix || exit
mkdir -p hosts/"$hostName"
cp hosts/default/*.nix hosts/"$hostName"
git config --global user.name "installer"
git config --global user.email "installer@mail.com"
git add .
sed -i "/^\s*host[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$hostName\"/" ./flake.nix

read -rp "Enter your keyboard layout: [ Default: us ] " keyboardLayout
if [ -z "$keyboardLayout" ]; then
  keyboardLayout="us"
fi

sed -i "/^\s*keyboardLayout[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$keyboardLayout\"/" ./hosts/$hostName/variables.nix

# System Theme Selection
read -rp "Enter your system theme: [ (dracula), cattpuccin, stylix ] " basetheme
if [ -z "$basetheme" ]; then
  basetheme="dracula"
  variant="default"
elif [ "$basetheme" == "dracula" ]; then
  basetheme="dracula"
  variant="default"
elif [ "$basetheme" == "cattpuccin" ]; then
  read -rp "Enter your cattpuccin theme: [ latte, frappe, macchiato, mocha ] " variant
  if [ -z "$variant" ]; then
    variant="macchiato"
  fi
elif [ "$basetheme" == "stylix" ]; then
  basetheme="stylix"
  variant="default"
else
  echo "Invalid system theme. Please choose either dracula, cattpuccin, or stylix."
  exit
fi

# Update systemTheme in variables.nix
sed -i "/^\s*systemTheme[[:space:]]*=[[:space:]]*{/c\  systemTheme = { name = \"$basetheme\"; variant = \"$variant\"; };" ./hosts/$hostName/variables.nix

echo "Your system theme will be set to $variant variant of $basetheme."

installusername=$(echo $USER)
sed -i "/^\s*username[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$installusername\"/" ./flake.nix

echo "Generating The Hardware Configuration"
sudo nixos-generate-config --show-hardware-config > ./hosts/$hostName/hardware.nix

echo "Setting Required Nix Settings Then Going To Install"

# Pass experimental features directly to nixos-rebuild
sudo NIX_CONFIG="experimental-features = nix-command flakes" nixos-rebuild switch --flake ~/solnix/#${hostName}

