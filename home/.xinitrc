#!/bin/bash

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
	xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
	xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
	xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && source "$f"
	done

	unset f
fi

# termite
source /etc/profile.d/vte.sh

# gnome-keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# desktop
setxkbmap gb &
nitrogen --restore &
xfce4-panel &
nm-applet &
parcellite &
dex /etc/xdg/autostart/geoclue-demo-agent.desktop &
dex /usr/share/applications/redshift-gtk.desktop &
insync start &
pacmd load-module module-alsa-sink device=hw:0,1 & # Fix Headphone
compton --config ~/.config/compton/compton.conf &
exec i3
