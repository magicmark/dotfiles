function _set_mbp_screen_2x {
    if [[ ! `xrandr | grep VGA-1 | grep 2880` ]]; then
        xrandr --newmode "2880x1800_60.00"  442.00  2880 3104 3416 3952  1800 1803 1809 1865 -hsync +vsync
        xrandr --addmode VGA-1 2880x1800_60.00
    fi
}

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

function _restart_i3 {
    i3-msg restart
    feh --bg-fill bg3.png
}

function screenset {

    if [[ $1 == 'mbp' ]]; then

        echo "Setting display for MacBook Pro (MBP@1x)"
        xrandr \
            --output VGA-1 --mode 1440x900 --dpi 96 \
            --output VGA-2 --off \
            --output VGA-3 --off

    elif [[ $1 == 'mbp@2x' ]]; then

        _set_mbp_screen_2x

        echo "Setting display for MacBook Pro (MBP@2x)"
        xrandr \
            --output VGA-1 --mode 2880x1800_60.00 --dpi 180 \
            --output VGA-2 --off \
            --output VGA-3 --off

    elif [[ $1 == 'dell' ]]; then

        _set_home_dell

        echo "Setting display for Dell U2713HM"
        xrandr \
            --output VGA-1 --mode 2560x1440_60.00 \
            --output VGA-2 --off \
            --output VGA-3 --off

    elif [[ $1 == 'samsung' ]]; then

        echo "Setting display for MacBook Pro + Samsung"
        xrandr \
            --output VGA-1 --mode 1440x900 --dpi 96 \
            --output VGA-2 --mode 1920x1080 --dpi 102 \
            --output VGA-3 --off

    elif [[ $1 == 'work' ]]; then

        _set_work_monitor_right

        echo "Setting display for work (MBP - Monitor - Monitor Sideways)"
        xrandr \
            --output VGA-1 --mode 1440x900 --dpi 96 \
            --output VGA-2 --mode 1920x1200 --right-of VGA-1 \
            --output VGA-3 --mode 1200x1920_59.90 --right-of VGA-2

    fi

    _restart_i3
}
