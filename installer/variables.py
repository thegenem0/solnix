import dataclasses
import os

@dataclasses.dataclass(frozen=True)
class SystemTheme:
    name: str
    variant: str

    def to_dict(self):
        return {
            "name": f'"{self.name}"',
            "variant": f'"{self.variant}"'
        }

@dataclasses.dataclass(frozen=True)
class GraphicsConfig:
    enable: bool
    extraConfig: dict

    def to_dict(self):
        return {
            "enable": str(self.enable).lower(),
            **self.extraConfig
        }

@dataclasses.dataclass(frozen=True)
class NixVariables:
    clock24h: bool
    systemTheme: SystemTheme
    amd: GraphicsConfig
    nvidia: GraphicsConfig
    intel: GraphicsConfig
    keyboardLayout: str
    browser: str
    terminal: str

    def to_dict(self):
        return {
            "clock24h": str(self.clock24h).lower(),
            "systemTheme": self.systemTheme.to_dict(),
            "amd": self.amd.to_dict(),
            "nvidia": self.nvidia.to_dict(),
            "intel": self.intel.to_dict(),
            "keyboardLayout": f'"{self.keyboardLayout}"',
            "browser": f'"{self.browser}"',
            "terminal": f'"{self.terminal}"'
        }

default_nix_variables = NixVariables(
    clock24h=True,
    systemTheme=SystemTheme("dracula", "default"),
    amd=GraphicsConfig(enable=False, extraConfig={}),
    nvidia=GraphicsConfig(
        enable=False,
        extraConfig={
            "prime": {
                "intelBusID": '""',
                "nvidiaBusID": '""'
            }
        }
    ),
    intel=GraphicsConfig(enable=True, extraConfig={}),
    keyboardLayout="us",
    browser="firefox",
    terminal="kitty"
)

def _write_dict_to_nix(d: dict, f, indent: int = 2):
    """Recursively writes a NixConfig object to a file in Nix format."""
    for key, value in d.items():
        f.write(" " * indent + f"{key} = ")
        if isinstance(value, dict):
            f.write("{\n")
            _write_dict_to_nix(value, f, indent + 2)
            f.write(" " * indent + "};\n")
        else:
            f.write(f"{value};\n")

def write_vars_file(host_path: str, config: NixVariables = default_nix_variables):
    nix_variables = config.to_dict()
    os.makedirs(os.path.dirname(host_path), exist_ok=True)

    with open(host_path, "w") as f:
        f.write("{\n")
        _write_dict_to_nix(nix_variables, f, indent=2)
        f.write("}\n")

    print(f"Generated {host_path} successfully.")
