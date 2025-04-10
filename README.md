# asahi-fedora-dots

This repo includes my dotfiles for hyprland on asahi fedora remix.

The setup script creates symlinks from the dotfiles in this directory to where the above packages use the .conf files.

## Required packages
- Hyprland
- Hyprshot
- Hyprlock
- Hypridle
- swww
- thunar
- fastfetch
- cargo

To install these on Fedora:

```bash
sudo dnf install hyprland hyprshot hyprlock hypridle thunar

## Enable full native resolution (notch support)

By default, asahi linux does not use the screen area to the sides of the beloved apple notch.

To unlock the full 3024x1964 display resolution on the 2021 M1 MacBook Pro and use the area around the notch:

1. Add the kernel parameter:
   ```bash
   apple_dcp.show_notch=1
2. Reboot
3. Update your Hyprland config (already included in this)
```ini 
monitor=eDP-1,3024x1964@60,0x0,2
monitor=eDP-1,addreserved,0,0,0,0
```
```
```

