#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A CONFIG_LINKS=(
  ["$HOME/.config/hypr/hyprland.conf"]=".config/hypr/hyprland.conf"
  ["$HOME/.config/hypr/hyprlock.conf"]=".config/hypr/hyprlock.conf"
  ["$HOME/.config/hypr/hypridle.conf"]=".config/hypr/hypridle.conf"
  ["$HOME/.config/hypr/swww"]=".config/hypr/swww"
  ["$HOME/.config/waybar"]=".config/waybar"
)

echo "Setting up symlinks from dotfiles..."

for DEST in "${!CONFIG_LINKS[@]}"; do
  SRC="$SCRIPT_DIR/${CONFIG_LINKS[$DEST]}"

  if [ -e "$DEST" ] || [ -L "$DEST" ]; then
    echo "$DEST already exists."
    read -p "Do you want to replace it with a symlink to $SRC? (y/n): " answer
    if [[ "$answer" =~ ^[Yy]$ ]]; then
      echo "Removing $DEST"
      rm -rf "$DEST"
    else
      echo "Skipping $DEST"
      continue
    fi
  fi

  mkdir -p "$(dirname "$DEST")"

  ln -s "$SRC" "$DEST"
  echo "Linked $DEST → $SRC"
done

echo "Done setting up your dotfiles!"
