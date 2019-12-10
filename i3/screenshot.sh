#!/bin/sh

mkdir $HOME/Pictures/screenshots
FILEPATH=$HOME/Pictures/screenshots
FILENAME="Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

scrot "$FILEPATH/$FILENAME"
