import subprocess

def get_user_input(prompt, default_value=""):
    user_input = input(f"{prompt} [{default_value}]: ").strip()
    return user_input if user_input else default_value

def show_menu(options, prompt="Choose an option:"):
    print("\n" + prompt)
    for i, option in enumerate(options, 1):
        print(f"{i}. {option}")

    while True:
        try:
            choice = int(input("Enter your choice: "))
            if 1 <= choice <= len(options):
                return options[choice - 1]
            else:
                print("Invalid choice, try again.")
        except ValueError:
            print("Invalid input, please enter a number.")

def get_hostname():
    current_hostname = subprocess.getoutput("hostname")
    new_hostname = get_user_input(f"Enter new hostname, or leave blank to keep current hostname", current_hostname)
    print(f"Hostname set to: {new_hostname}")
    return new_hostname

def get_keyboard_layout():
    keyboard_layout = get_user_input("Enter your keyboard layout", "us")
    print(f"Keyboard layout set to: {keyboard_layout}")
    return keyboard_layout

def get_system_theme():
    themes = ["dracula", "cattpuccin", "stylix"]
    basetheme = show_menu(themes, "Select your system theme:")

    variant = "default"
    if basetheme == "cattpuccin":
        variants = ["latte", "frappe", "macchiato", "mocha"]
        variant = show_menu(variants, "Select your cattpuccin variant:")

    print(f"System theme set to {basetheme} with variant {variant}")
    return basetheme, variant


def get_gpu_config():
    gpus = ["amd", "nvidia", "intel"]
    gpu = show_menu(gpus, "Select your GPU:")
    if gpu == "amd":
        extraConfig = {}
    elif gpu == "nvidia":
        extraConfig = {
            "prime": {
                "enable": "false",
                "intelBusID": '""',
                "nvidiaBusID": '""'
            }
        }
    elif gpu == "intel":
        extraConfig = {}

    return gpu, extraConfig
