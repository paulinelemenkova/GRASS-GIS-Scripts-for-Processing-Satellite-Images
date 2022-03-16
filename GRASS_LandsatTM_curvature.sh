#!/bin/sh
# GRASS GIS script for plotting slope map from DEM of Landsat TM image.
# Region: Qingdao, China.

# show raster dataset content
g.list rast

# calculate and model slope from DEM
r.slope.aspect elevation=lsat7_2009_DEM slope=Qslope aspect=Qaspect pcurvature=Qpcurv tcurvature=Qtcurv

# display slope map
g.region raster=lsat7_2009_DEM -p
d.mon wx1
d.erase
r.colors -a map=Qaspect color=aspectcolr
d.rast Qaspect

# legend
d.legend raster=Qaspect title=Aspect,grad title_fontsize=8 font=Arial fontsize=8 -t -b bgcolor=white label_step=15 border_color=gray thin=8
d.text text="Aspect map" color=blue size=3.0 font="Trebuchet MS"

# border
v.in.region output=Topo_DEM_bbox
g.list vect
v.info map=Topo_DEM_bbox
d.vect Topo_DEM_bbox color=red width=3 fill_color="none"

# grid
d.grid -w size=0.5 color=white border_color=yellow width=0.1 fontsize=8 text_color=blue bgcolor=white
