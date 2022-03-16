#!/bin/sh
# GRASS GIS script for plotting slope map from DEM of Landsat TM image.
#
# show raster dataset content
g.list rast

# calculate and model slope from DEM
r.slope.aspect elevation=lsat7_2009_DEM slope=Qslope aspect=Qaspect pcurvature=Qpcurv tcurvature=Qtcurv

# display slope map
g.region raster=lsat7_2009_DEM -p
d.mon wx1
d.erase
r.colors -a map=Qslope color=rainbow
d.rast Qslope

# legend
d.legend raster=Qslope title=Slope,grad title_fontsize=8 font=Arial fontsize=8 -t -b bgcolor=white label_step=15 border_color=gray thin=8
d.text text="Slope map" color=blue size=3.0 font="Trebuchet MS"

# border
v.in.region output=Topo_DEM_bbox
g.list vect
v.info map=Topo_DEM_bbox
d.vect Topo_DEM_bbox color=red width=3 fill_color="none"

# grid
d.grid -w size=0.5 color=grey border_color=yellow width=0.1 fontsize=8 text_color=blue bgcolor=white
