#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

declare -A CONFIG_LINKS=(
  ["$HOME/.config/hypr/hyprland.conf"]=".config/hypr/hyprland.conf"
  ["$HOME/.config/hypr/hyprlock.conf"]=".config/hypr/hyprlock.conf"
  ["$HOME/.config/hypr/hypridle.conf"]=".config/hypr/hypridle.conf"
  ["$HOME/.config/hypr/swww"]=".config/hypr/swww"
  ["$HOME/.config/hypr/keybinds.txt"]=".config/hypr/keybinds.txt"
  ["$HOME/.config/waybar"]=".config/waybar"
  ["$HOME/.config/fastfetch/config.jsonc"]=".config/fastfetch/config.jsonc"
  ["$HOME/.local/bin/pokefetch"]=".local/bin/pokefetch"
  ["$HOME/.local/bin/show-binds"]=".local/bin/show-binds"
  ["$HOME/.zshrc"]=".zshrc"
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

echo
echo "Checking for required packages..."

REQUIRED_PKGS=(fastfetch hyprland hyprlock hypridle thunar)

for pkg in "${REQUIRED_PKGS[@]}"; do
  if ! command -v "$pkg" &>/dev/null; then
    echo "Installing missing package: $pkg"
    sudo dnf install -y "$pkg"
  else
    echo "$pkg is already installed"
  fi
done

if ! command -v pokeget &>/dev/null; then
  echo "pokeget not found, installing with cargo..."
  if ! command -v cargo &>/dev/null; then
    echo "Cargo is not installed. Installing Rust toolchain..."
    sudo dnf install -y cargo
  fi
  cargo install pokeget
else
  echo "pokeget is already installed"
fi

echo
echo "Checking if ~/.cargo/bin is in PATH..."

if ! echo "$PATH" | grep -q "$HOME/.cargo/bin"; then
  echo 'export PATH="$HOME/.cargo/bin:$PATH"' >>"$HOME/.zshrc"
  echo "Added ~/.cargo/bin to PATH in .zshrc"
fi

echo
echo "Sourcing .zshrc..."
source "$HOME/.zshrc"

echo
echo "Setup complete!"
