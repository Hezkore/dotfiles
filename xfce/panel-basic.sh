#!/bin/bash

ICON_SIZE=28
TRAY_ICON_SIZE=16
PANEL_HEIGHT=38
PANEL_BORDER=0
PANEL_COLOR_R=0.020
PANEL_COLOR_G=0.023
PANEL_COLOR_B=0.04
PANEL_COLOR_A=0.98

echo "Applying new XFCE4 panel layout..."

# Get screen width using xrandr
WIDTH=$(xrandr | grep '*' | awk '{print $1}' | cut -d'x' -f1 | head -n1)
HEIGHT=$(xrandr | grep '*' | awk '{print $1}' | cut -d'x' -f2 | head -n1)

# Validate width
if [[ -z "$WIDTH" || "$WIDTH" -le 100 ]]; then
	echo "Error: Invalid or very low screen width ($WIDTH). Aborting."
	exit 1
fi

# Calculate panel widths
PANEL_WIDTH=33.333333
PANEL_WIDTH_MID=33.377777

# Calculate positions
POS_Y=$HEIGHT
POS_X1=0
POS_X2=$(( $WIDTH / 2 ))
POS_X3=$WIDTH

# Remove all current panels
xfconf-query -c xfce4-panel -p /panels -rR
xfconf-query -c xfce4-panel -p /plugins -rR

sleep 1

# Start XFCE4 panel if it's not running, otherwise restart it!
if ! pgrep -x "xfce4-panel" > /dev/null; then
	xfce4-panel &
else
	xfce4-panel --restart
fi


sleep 2

# Create 3 panels
xfconf-query -c xfce4-panel -p /panels -n -t int -s 1 -t int -s 2 -t int -s 3

# Loop to create each panel
for i in 1 2 3; do
	case $i in
		1)
			CUR_ICON_SIZE=$ICON_SIZE
			LENGTH=$PANEL_WIDTH
			POS_X=$POS_X1
			POS_P=8
			;;
		2)
			CUR_ICON_SIZE=$ICON_SIZE
			LENGTH=$PANEL_WIDTH_MID
			POS_X=$POS_X2
			POS_P=10
			;;
		3)
			CUR_ICON_SIZE=$TRAY_ICON_SIZE
			LENGTH=$PANEL_WIDTH
			POS_X=$POS_X3
			POS_P=4
			;;
	esac
	
	xfconf-query -c xfce4-panel -p /panels/panel-$i/position -n -t string -s "p=$POS_P;x=$POS_X;y=$POS_Y"
	xfconf-query -c xfce4-panel -p /panels/panel-$i/length -n -t double -s $LENGTH
	xfconf-query -c xfce4-panel -p /panels/panel-$i/size -n -t int -s $PANEL_HEIGHT
	xfconf-query -c xfce4-panel -p /panels/panel-$i/border-width -n -t int -s $PANEL_BORDER
	xfconf-query -c xfce4-panel -p /panels/panel-$i/icon-size -n -t int -s $CUR_ICON_SIZE
	xfconf-query -c xfce4-panel -p /panels/panel-$i/position-locked -n -t bool -s true
	xfconf-query -c xfce4-panel -p /panels/panel-$i/length-adjust -n -t bool -s true
	xfconf-query -c xfce4-panel -p /panels/panel-$i/background-style -n -t int -s 1
	xfconf-query -c xfce4-panel -p /panels/panel-$i/background-rgba -n -t double -s $PANEL_COLOR_R -t double -s $PANEL_COLOR_G -t double -s $PANEL_COLOR_B -t double -s $PANEL_COLOR_A
done

### PANEL 1 PLUGINS - id 100
# Whisker menu
xfconf-query -c xfce4-panel -p /plugins/plugin-100 -n -t string -s whiskermenu
xfconf-query -c xfce4-panel -p /plugins/plugin-100/menu-width -n -t int -s 770
xfconf-query -c xfce4-panel -p /plugins/plugin-100/menu-height -n -t int -s 600
xfconf-query -c xfce4-panel -p /plugins/plugin-100/menu-opacity -n -t int -s 98
xfconf-query -c xfce4-panel -p /plugins/plugin-100/position-commands-alternate -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-100/position-search-alternate -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-100/show-button-title -n -t bool -s false
xfconf-query -c xfce4-panel -p /plugins/plugin-100/hover-switch-category -n -t bool -s false
xfconf-query -c xfce4-panel -p /plugins/plugin-100/launcher-icon-size -n -t int -s 4

# Apply
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids -n --force-array -t int -s 100

### PANEL 2 PLUGINS - id 200
# Separator - left
xfconf-query -c xfce4-panel -p /plugins/plugin-200 -n -t string -s separator
xfconf-query -c xfce4-panel -p /plugins/plugin-200/expand -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-200/style -n -t int -s 0
# Docklike Taskbar
xfconf-query -c xfce4-panel -p /plugins/plugin-201 -n -t string -s docklike
# Write Docklike Taskbar Config
echo -e "[user]\nnoWindowsListIfSingle=true\nshowPreviews=true\nshowWindowCount=false\nonlyDisplayScreen=false\nonlyDisplayVisible=false\nindicatorColorFromTheme=false\nmiddleButtonBehavior=1\nindicatorStyle=3\ninactiveIndicatorStyle=1\ninactiveColor=rgb(201,201,201)\nindicatorColor=rgb(220,138,221)\nforceIconSize=true\nkeyComboActive=true\nkeyAloneActive=false\niconSize=${ICON_SIZE}\npinned=thunar;floorp;" > ~/.config/xfce4/panel/docklike-201.rc
# Separator - right
xfconf-query -c xfce4-panel -p /plugins/plugin-202 -n -t string -s separator
xfconf-query -c xfce4-panel -p /plugins/plugin-202/expand -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-202/style -n -t int -s 0

# Apply
xfconf-query -c xfce4-panel -p /panels/panel-2/plugin-ids  -n -t int -s 200 -t int -s 201 -t int -s 202

### PANEL 3 PLUGINS - id 300
# Separator - left
xfconf-query -c xfce4-panel -p /plugins/plugin-300 -n -t string -s separator
xfconf-query -c xfce4-panel -p /plugins/plugin-300/expand -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-300/style -n -t int -s 0
# System Tray
xfconf-query -c xfce4-panel -p /plugins/plugin-301 -n -t string -s systray
xfconf-query -c xfce4-panel -p /plugins/plugin-301/icon-size -n -t int -s 0
xfconf-query -c xfce4-panel -p /plugins/plugin-301/square-icons -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-301/symbolic-icons -n -t bool -s true
# Clipman
xfconf-query -c xfce4-panel -p /plugins/plugin-302 -n -t string -s xfce4-clipman-plugin
# Volume Control
xfconf-query -c xfce4-panel -p /plugins/plugin-303 -n -t string -s pulseaudio
xfconf-query -c xfce4-panel -p /plugins/plugin-303/enable-keyboard-shortcuts -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-303/play-sound -n -t bool -s true
# Separator
xfconf-query -c xfce4-panel -p /plugins/plugin-304 -n -t string -s separator
xfconf-query -c xfce4-panel -p /plugins/plugin-304/expand -n -t bool -s false
xfconf-query -c xfce4-panel -p /plugins/plugin-304/style -n -t int -s 0
# Clock
xfconf-query -c xfce4-panel -p /plugins/plugin-305 -n -t string -s clock
xfconf-query -c xfce4-panel -p /plugins/plugin-305/digital-layout -n -t int -s 1
xfconf-query -c xfce4-panel -p /plugins/plugin-305/digital-date-font -n -t string -s "Sans Bold 9"
xfconf-query -c xfce4-panel -p /plugins/plugin-305/digital-time-font -n -t string -s "Sans Bold 9"
# Separator
xfconf-query -c xfce4-panel -p /plugins/plugin-306 -n -t string -s separator
xfconf-query -c xfce4-panel -p /plugins/plugin-306/expand -n -t bool -s false
xfconf-query -c xfce4-panel -p /plugins/plugin-306/style -n -t int -s 0
# Notifications
xfconf-query -c xfce4-panel -p /plugins/plugin-307 -n -t string -s notification-plugin
xfconf-query -c xfce4-notifyd -p /plugin/hide-on-read -n -t bool -s true
# Show Desktop
xfconf-query -c xfce4-panel -p /plugins/plugin-308 -n -t string -s showdesktop

# Apply
xfconf-query -c xfce4-panel -p /panels/panel-3/plugin-ids -n -t int -s 300 -t int -s 301 -t int -s 302 -t int -s 303 -t int -s 304 -t int -s 305 -t int -s 306 -t int -s 307 -t int -s 308

# Start XFCE4 panel if it's not running, otherwise restart it!
if ! pgrep -x "xfce4-panel" > /dev/null; then
	xfce4-panel &
else
	xfce4-panel --restart
fi

echo "Done"

exit 0