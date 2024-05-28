#!/bin/sh
# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

setxkbmap setxkbmap -layout us -variant intl &
xrdb -merge ~/.Xresources &
redshift &
xautolock -time 60 -locker 'systemctl suspend' &
picom --config $HOME/.config/picom/picom.conf &
nitrogen --set-zoom-fill --random ~/imgs/wallpapers &
unclutter -idle 3 &
setxkbmap setxkbmap -layout us -variant intl &

exec bspwm
