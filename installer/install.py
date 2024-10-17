#!/usr/bin/env python3

import os
import subprocess
import datetime
from variables import write_vars_file, NixVariables, SystemTheme, GraphicsConfig
from input import get_hostname, get_keyboard_layout, get_system_theme, get_gpu_config


def get_username():
    try:
        return subprocess.getoutput("whoami")
    except subprocess.CalledProcessError as e:
        print(f"Error getting username: {e}")

def set_installer_git_config():
    """Ensure nix doesn't build from a dirty git state."""
    try:
        if subprocess.run(["git", "config", "--global", "user.name"], stdout=subprocess.DEVNULL).returncode != 0:
            subprocess.run(["git", "config", "--global", "user.name", "installer"], check=True)
        if subprocess.run(["git", "config", "--global", "user.email"], stdout=subprocess.DEVNULL).returncode != 0:
            subprocess.run(["git", "config", "--global", "user.email", "installer@mail.com"], check=True)

        subprocess.run(["git", "add", "."], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error setting Git config: {e}")

def setup_flake(solnix_dir: str, hostname: str, username: str):
    """Set the username for the flake."""
    cpCmd = f"cp {solnix_dir}/hosts/default/*.nix {solnix_dir}/hosts/{hostName}"
    hostnameCmd = f'sed -i "/^\\s*host[[:space:]]*=[[:space:]]*\\\"/s/\\\"\\(.*\\)\\\"/\\\"{hostname}\\\"/" {solnix_dir}/flake.nix'
    usernameCmd = f'sed -i "/^\\s*username[[:space:]]*=[[:space:]]*\\\"/s/\\\"\\(.*\\)\\\"/\\\"{username}\\\"/" {solnix_dir}/flake.nix'
    try:
        subprocess.run(cpCmd, shell=True, check=True)
        subprocess.run(hostnameCmd, shell=True, check=True)
        subprocess.run(usernameCmd, shell=True, check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error setting username in flake.nix: {e}")

def install_solnix(solnix_dir: str, hostname: str):
    config_file = f"{solnix_dir}/hosts/{hostname}/hardware.nix"
    try:
        os.makedirs(f"{solnix_dir}/hosts/{hostname}", exist_ok=True)
    except FileExistsError:
        print(f"Host directory already exists at {config_file}.")

    with open(config_file, 'w') as file:
        try:
            subprocess.run(["sudo", "nixos-generate-config", "--show-hardware-config"], stdout=file)
        except subprocess.CalledProcessError as e:
            print(f"Error generating hardware config: {e}")

    print(f"Hardware configuration generated at {config_file}.")
    print("Applying the NixOS installation")

    try:
        subprocess.run(
            f"sudo NIX_CONFIG='experimental-features = nix-command flakes' nixos-rebuild switch --flake {solnix_dir}/#{hostname}",
            shell=True,
            check=True
        )
    except subprocess.CalledProcessError as e:
        print(f"Error applying NixOS installation: {e}")

def main():
    solnix_dir = os.path.expanduser("~/solnix")
    os.chdir(solnix_dir)

    username = get_username()
    hostname = get_hostname()
    keyboard_layout = get_keyboard_layout()
    basetheme, variant = get_system_theme()
    gpu, extraConfig = get_gpu_config()

    print(f"Installing with following settings:\n"
        f"Username: {username}\n"
        f"Hostname: {hostname}\n"
        f"Keyboard Layout: {keyboard_layout}\n"
        f"System Theme: {basetheme} {variant}\n"
        f"GPU: {gpu}\n"
    )

    config = NixVariables(
        clock24h=True,
        systemTheme=SystemTheme(basetheme, variant),
        amd=GraphicsConfig(
            enable= True if gpu == "amd" else False,
            extraConfig= extraConfig if gpu == "amd" else {}
        ),
        nvidia=GraphicsConfig(
            enable= True if gpu == "nvidia" else False,
            extraConfig= extraConfig if gpu == "nvidia" else {}
        ),
        intel=GraphicsConfig(
            enable= True if gpu == "intel" else False,
            extraConfig= extraConfig if gpu == "intel" else {}
        ),
        keyboardLayout=keyboard_layout,
        browser="firefox",
        terminal="kitty"
    )

    setup_flake(solnix_dir, hostname, username)

    set_installer_git_config()

    write_vars_file(host_path=f"{solnix_dir}/hosts/{hostname}/variables.nix", config=config)

    install_solnix(solnix_dir, hostname)

if __name__ == "__main__":
    main()

