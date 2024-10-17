{ ... }:
{
  home.file = {
    ".ssh/config".source = ./config;
    ".ssh/known_hosts".source = ./known_hosts;
  };
}

