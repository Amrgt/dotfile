#!/usr/bin/env bash

COLOR="$RED"

sketchybar --add item ram right \
  --set ram \
  update_freq=2 \
  icon.color="$COLOR" \
  icon.padding_left=4 \
  label.color="$COLOR" \
  label.padding_right=10 \
  background.height=26 \
  background.corner_radius="$CORNER_RADIUS" \
  background.padding_right=5 \
  background.border_width="$BORDER_WIDTH" \
  background.border_color="$COLOR" \
  background.color="$BAR_COLOR" \
  background.drawing=on \
  script="$PLUGIN_DIR/ram.sh"
