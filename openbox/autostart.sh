# This shell script is run before Openbox launches.
# Environment variables set here are passed to the Openbox session.

TERM=urxvt

# Set a background color
BG=""
if which hsetroot >/dev/null; then
    BG=hsetroot
else
    if which esetroot >/dev/null; then
        BG=esetroot
    else
        if which xsetroot >/dev/null; then
            BG=xsetroot
        fi
    fi
fi
test -z $BG || $BG -solid "#303030"

# D-bus
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
       eval `dbus-launch --sh-syntax --exit-with-session`
fi

setxkbmap -option "grp:switch,grp:ctrl_shift_toggle" "us,ru(winkeys)"

uname=`uname`

case $uname in
    Linux*)
        docker &
        nm-applet --sm-disable &
        gnome-power-manager &
        ;;
esac

test -f ~/.Xmodmap && xmodmap ~/.Xmodmap

$TERM -e tmux &
