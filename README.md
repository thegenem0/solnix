# SolNix - My NixOS Flake for Work/Personal Use

## Introduction

This is my system configuration for NixOS. I use this at my day job as a software engineer, and at home as my main machine.
It's an opinionated set of configurations, and is designed to be a single-script installation to get a new system up and running quickly.

## Installation

### Prerequisites

This is intended to be installed on NixOS, and the install script will only work on NixOS.

The home-manager configuration should, **in theory**, work on any Linux distribution with a working Nix installation,
but I haven't tested it, and there may be some system-wide dependencies that will need to be installed manually.

### Installation

Launch a new nix-shell with the following command:

```bash
nix-shell -p curl git python3
```

Then, run the installation script:

```bash
sh <(curl -L https://gitlab.com/solinaire/solnix/-/raw/main/install.sh)
```

Follow the prompts to configure the installation.

1. Enter a hostname for your system. (this will be pre-populated with the current hostname if you wish to keep it)
2. Enter your keyboard layout.
3. Enter the name of your primary monitor. (if you don't know, you can leave this as is, and update the `hosts/{hostname}/variables.nix` file later)
3. Select your system theme.
  - Depending on your system theme, you may need to select a variant/wallpaper.
4. Select your GPU.

Once the installation is complete, just reboot your system and you should be good to go!
