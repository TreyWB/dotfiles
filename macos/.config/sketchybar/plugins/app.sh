#!/bin/bash

FOCUSED_APP=$(osascript -e 'tell application "System Events" to get name of first application process whose frontmost is true')

if [[ $FOCUSED_APP = "" ]]; then
  FOCUSED_APP="Desktop"
fi

sketchybar --set $NAME label="$FOCUSED_APP"
