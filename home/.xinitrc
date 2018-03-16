#!/bin/sh

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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


# CUSTOM


## TERMITE
source /etc/profile.d/vte.sh

## DESKTOP
# nv-fan & # set nvidia fan speed
# setxkbmap -option grp:alt_shift_toggle gb # set uk layout
nitrogen --restore & # set wallpaper
xsetroot -cursor_name left_ptr & # set desktop cursor to be pointer
i3 & # wm
xfce4-panel & # status bar
pkill -9 insync &
redshift-gtk &
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK
#eval $(ssh-agent) &
#eval $(gpg-agent --enable-ssh-support --daemon --sh) &
insync start &
exec compton --config /home/me/.config/compton.conf --xrender-sync --xrender-sync-fence # compositor needs to run last
