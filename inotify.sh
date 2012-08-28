#!/bin/sh

CURPATH=`pwd`

inotifywait -mr --timefmt '%d/%m/%y %H:%M' --format '%T %w %f' \
-e close_write $CURPATH/contents $CURPATH/templates | while read date time dir file; do
  FILECHANGE=${dir}${file}
  # convert absolute path to relative
  FILECHANGEREL=`echo "$FILECHANGE" | sed 's_'$CURPATH'/__'`
  echo "At ${time} on ${date}, file $FILECHANGEREL has changed!"
  rm -rf build/*
  wintersmith build
  WID=`xdotool search --name "Le blog" | head -1`
  xdotool windowactivate $WID
  xdotool key ctrl+r
done
