# ~/.xinitrc
# This file is sourced when running startx and other programs which call xinit

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# Set first monitor as "main"
export SDL_VIDEO_FULLSCREEN_HEAD=0

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

# Make sure this is before the 'exec' command or it won't be sourced.
#[ -f /etc/xprofile ] && source /etc/xprofile
#[ -f ~/.xprofile ] && source ~/.xprofile
#[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# Start polkit
lxpolkit &

# Start autokey (Remap some iso keybindings)
autokey &

# Start a terminal
/usr/bin/X11/terminator &

# Set wallpaper
feh --bg-fill /usr/share/wallpapers/jinx-nord.png &

# Start the systems window manager.
exec /usr/local/bin/i3
