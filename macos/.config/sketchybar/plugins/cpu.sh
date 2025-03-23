#!/bin/bash

sketchybar --set "$NAME" label="$(top -l 2 | grep -E "^CPU" | tail -1 | awk '{ printf "%.0f%%", $3 + $5"%" }')"
