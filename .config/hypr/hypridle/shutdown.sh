#!/bin/bash
# Shuts down laptop when locked and lid closed
SESSION_ID=$(loginctl | grep "$USER" | awk '{print $1}')

LOCKED=$(loginctl show-session "$SESSION_ID" -p Locked | cut -d= -f2)

LID_STATE=$(awk '{print $2}' /proc/acpi/button/lid/LID0/state)

if [[ "$LOCKED" == "yes" && "$LID_STATE" == "closed" ]]; then
  systemctl poweroff
fi
