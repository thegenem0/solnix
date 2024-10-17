#!/usr/bin/env bash

username=$(whoami)

wall_dir="/home/${username}/Pictures/Wallpapers"
rofi_theme="/home/${username}/.config/rofi/wallselect.rasi"

selected=$( find "$wall_dir" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" \) -exec basename {} \; | sort -R | while read rfile
  do
      echo -en "$rfile\x00icon\x1f$wall_dir/$rfile\n"
  done | rofi -dmenu -i -replace -config $rofi_theme)
  if [ ! "$selected" ]; then
      echo "No wallpaper selected"
      exit
  fi

if [ -n "$selected" ]; then
  if pgrep -x "swww-daemon" > /dev/null; then
      echo "swww-daemon is already running"
  else
      echo "Starting swww-daemon"
      swww-daemon &
      sleep 0.5
  fi

  if [ -L "/home/${username}/.config/.current_wallpaper" ]; then
   rm "/home/${username}/.config/.current_wallpaper"
  fi

  ln -s "$selected" "/home/${username}/.config/.current_wallpaper"

  blurred_wallpaper="/home/${username}/.config/.blurred_wallpaper"
  if [ -f "$blurred_wallpaper" ]; then
     rm "$blurred_wallpaper"
  fi

  magick "$selected" -blur 0x8 "$blurred_wallpaper"

  # Set the wallpaper using swww
  swww img "$selected" --transition-type=wipe --transition-duration=0.7

  # Notify the user
  notify-send "Wallpaper changed!" "New wallpaper set: $(basename "$selected")"
else
  exit 1
fi

exit 0

