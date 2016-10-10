function _set_home_dell {
    if [[ ! `xrandr | grep VGA-1 | grep 2560 ` ]]; then
        xrandr --newmode "2560x1440_60.00"  312.25  2560 2752 3024 3488  1440 1443 1448 1493 -hsync +vsync
        xrandr --addmode VGA-1 2560x1440_60.00
    fi
}

function _set_work_monitor_right {
    if [[ ! -n `xrandr | grep VGA-3 | grep 1200` ]]; then
        xrandr --newmode "1200x1920_59.90"  196.05  1200 1296 1424 1648  1920 1921 1924 1986  -HSync +Vsync
        xrandr --addmode VGA-3 "1200x1920_59.90"
    fi
}

function _clear_other_screens {
    local other_screens=$(xrandr | grep -E "^[a-zA-Z0-9-]+ (dis)?connected" | cut -d ' ' -f 1)
    for screen in $other_screens; do
        xrandr --output "$screen" --off
    done
}

function _restart_i3 {
    i3-msg restart
    feh --bg-fill ~/backgrounds/fish.jpg
}

function screenset {

    _clear_other_screens

    if [[ $1 == 'mbp@2x' ]]; then

        echo "Setting display for MacBook Pro (MBP@2x)"
        xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180

    elif [[ $1 == 'dell' ]]; then

        _set_home_dell

        echo "Setting display for Dell U2713HM"
        xrandr \
            --output VGA-1 --mode 2560x1440_60.00

    elif [[ $1 == 'samsung' ]]; then
        echo "Setting display for MacBook Pro + Samsung"
        xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180 \
            --output HDMI-3 --mode 1920x1080 \
                --panning 3840x2160+2800+0 \
                --scale 2x2 --right-of eDP-1

    elif [[ $1 == 'work' ]]; then

        _set_work_monitor_right

        echo "Setting display for work (MBP - Monitor - Monitor Sideways)"
        xrandr \
            --output eDP-1 --mode 2880x1800 --dpi 180
            --output VGA-2 --mode 1920x1200 --right-of eDP-1 \
            --output VGA-3 --mode 1200x1920_59.90 --right-of VGA-2

    fi

    _restart_i3
}
xrandr --output HDMI-3 --auto --panning 3840x2160+2800+0 --scale 2x2 --right-of eDP-1 --dpi 90
