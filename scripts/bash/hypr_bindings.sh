yad --width=800 --height=650 \
    --center \
    --fixed \
    --title="Hyprland Keybindings" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout=90 \
    --timeout-indicator=right \
    " = Windows/Super/CAPS LOCK" "Modifier Key" \
    " + ENTER" "Terminal" "${terminal}" \
    " + D" "App Launcher" "rofi" \
    " + SHIFT + W" "Change Wallpaper" "wallsetter" \
    " + SHIFT + Q" "Kill Focused Window" "killactive" \
    " + PRTSC" "Take Screenshot" "screenshot-select" \
    " + F" "Toggle Focused Fullscreen" "fullscreen" \
    " + 1-0" "Move To Workspace 1 - 10" "workspace,X" \
    " + SHIFT + 1-0" "Move Focused Window To Workspace 1 - 10" "movetoworkspace,X" \
    " + MOUSE_LEFT" "Move/Drag Window" "movewindow" \
    " + MOUSE_RIGHT" "Resize Window" "resizewindow" \
    ""
