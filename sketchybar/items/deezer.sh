#!/usr/bin/env bash

COLOR="$GREEN"

sketchybar --add item deezer q \
 --set deezer \
 scroll_texts=on \
 icon=󰎆 \
 icon.color="$COLOR" \
 icon.padding_left=10 \
 background.color="$BAR_COLOR" \
 background.height=26 \
 background.corner_radius="$CORNER_RADIUS" \
 background.border_width="$BORDER_WIDTH" \
 background.border_color="$COLOR" \
 background.padding_right=100 \
 background.padding_left=10 \
 background.drawing=on \
 label.max_chars=23 \
 associated_display=active \
 updates=on \
 script="$PLUGIN_DIR/deezer.sh" \
 --subscribe deezer media_change
