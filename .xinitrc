xrdb merge ~/.Xresources
xrandr && xrandr --output Virtual1 --mode 2880x1800 --dpi 180
# xsetroot -solid "#3E5059"
feh --bg-tile bg1.png
exec i3
