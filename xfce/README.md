# XFCE Desktop

My configuration for the [XFCE Desktop Environment](https://www.xfce.org/).

## Installation

It's hard to share any XFCE configurations, especially the panel.\
So what I've done is to write a couple of scripts that configure things automatically.

### Panel-basic

Will configure the panel to take the basic Windows-like taskbar shape.

* Tested on OpenSUSE Tumblweed
* Tested on a 5120x1440 resolution

If you get any "gaps" in the panel, change the `PANEL_WIDTH_MID` variable to `34`, and `PANEL_COLOR_A` to `1.0` in the script and run it again.
