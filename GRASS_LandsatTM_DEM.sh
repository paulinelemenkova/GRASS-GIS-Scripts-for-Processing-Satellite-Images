#!/bin/sh
# GRASS GIS script for processing and visualizing DEM from the Landsat TM image.
# Region: Qingdao, China.

gdalinfo L5121035_03520090519_DEM.TIF
# import the image subset and display the raster map
r.in.gdal L5121035_03520090519_B10.TIF out=lsat7_2009_10
r.in.gdal L5121035_03520090519_B20.TIF out=lsat7_2009_20
r.in.gdal L5121035_03520090519_B30.TIF out=lsat7_2009_30
r.in.gdal L5121035_03520090519_B40.TIF out=lsat7_2009_40
r.in.gdal L5121035_03520090519_B50.TIF out=lsat7_2009_50
r.in.gdal L5121035_03520090519_B60.TIF out=lsat7_2009_60
r.in.gdal L5121035_03520090519_B70.TIF out=lsat7_2009_70
r.in.gdal L5121035_03520090519_DEM.TIF out=lsat7_2009_DEM
g.list rast

g.region raster=lsat7_2009_DEM -p
d.mon wx0
d.erase
r.colors lsat7_2009_DEM col=srtm
d.rast lsat7_2009_DEM

# isolines
r.contour lsat7_2009_DEM out=Topo_DEM step=200 --overwrite
d.vect Topo_DEM color='brown' width=0

# grid
d.grid -w size=0.5 color=white border_color=yellow width=0.1 fontsize=8 text_color=blue bgcolor=white

# border
v.in.region output=Topo_DEM_bbox
g.list vect
v.info map=Topo_DEM_bbox
d.vect Topo_DEM_bbox color=red width=3 fill_color="none"

# legend
r.info lsat7_2009_DEM
# min = -12  max = 1119
d.legend raster=lsat7_2009_DEM range=-12,1119 title=Topography,m title_fontsize=8 font=Arial fontsize=7 -t -b -f bgcolor=white label_step=300 border_color=gray

# title
d.title map=lsat7_2009_DEM | d.text text="Topography: Qingdao area" color="red" size=5
d.text text="DEM" color=blue size=2.0 font="Trebuchet MS"
