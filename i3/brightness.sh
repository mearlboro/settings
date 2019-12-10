#!/bin/sh

FILE=/sys/class/backlight/intel_backlight/brightness
sudo chown $(whoami) $FILE

MAX=`cat /sys/class/backlight/intel_backlight/max_brightness`
INTERVAL=$(($MAX/20))
CURR=`cat $FILE`

if [ $1 = '--inc' ]
then
	NEW=$(($CURR + $INTERVAL))
	if [ "$NEW" -lt  "$MAX" ]; then
		echo $NEW > $FILE
	fi
fi

if [ $1 = '--dec' ]
then
	NEW=$(($CURR - $INTERVAL))
	if [ "$NEW" -gt "0" ]; then
		echo $NEW > $FILE
	fi
fi

if [ $1 = '--off' ]
then
   echo 0 > $FILE
fi

