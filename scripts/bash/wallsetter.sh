username=$(whoami)
wall_dir="/home/${username}/Pictures/Wallpapers"
rofi_theme="/home/${username}/.config/rofi/wallpapers.rasi"

selected=$(find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
    do
        echo -en "$rfile\x00icon\x1f$wall_dir/$rfile\n"
    done | rofi -dmenu -i -replace -config "$rofi_theme")

if [ -z "$selected" ]; then
    echo "No wallpaper selected"
    exit 1
fi

temp_dir="/tmp/wallsetter"
mkdir -p "$temp_dir"
temp_wallpaper="$temp_dir/$selected"
cp "$wall_dir/$selected" "$temp_wallpaper"

if pgrep -x "swww-daemon" > /dev/null; then
    echo "swww-daemon is already running"
else
    echo "Starting swww-daemon"
    swww-daemon &
    sleep 0.5
fi

current_wallpaper_link="/home/${username}/.config/.current_wallpaper"
if [ -L "$current_wallpaper_link" ]; then
    rm "$current_wallpaper_link"
fi
ln -s "$wall_dir/$selected" "$current_wallpaper_link"

blurred_wallpaper="/home/${username}/.config/.blurred_wallpaper"
magick "$temp_wallpaper" -blur 0x8 "$blurred_wallpaper"

swww img "$temp_wallpaper" --transition-type=wipe --transition-duration=0.7

notify-send "Wallpaper changed!" "New wallpaper set: $(basename "$selected")"

exit 0
