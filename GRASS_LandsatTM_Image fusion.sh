#!/bin/sh
# GRASS GIS script for processing and visualizing Landsat TM image. Region: Qingdao, China.
gdalinfo L5121035_03520090519_B10.TIF

# import the image subset and display the raster map
# 1st image
r.in.gdal L5121035_03520090519_B10.TIF out=lsat7_2009_10
r.in.gdal L5121035_03520090519_B20.TIF out=lsat7_2009_20
r.in.gdal L5121035_03520090519_B30.TIF out=lsat7_2009_30
r.in.gdal L5121035_03520090519_B40.TIF out=lsat7_2009_40
r.in.gdal L5121035_03520090519_B50.TIF out=lsat7_2009_50
r.in.gdal L5121035_03520090519_B60.TIF out=lsat7_2009_60
r.in.gdal L5121035_03520090519_B70.TIF out=lsat7_2009_70
r.in.gdal L5121035_03520090519_DEM.TIF out=lsat7_2009_DEM
g.list rast

# 2nd image
r.in.gdal L5121035_03520040910_B10.TIF out=lsat7_2004_10 --overwrite
r.in.gdal L5121035_03520040910_B20.TIF out=lsat7_2004_20 --overwrite
r.in.gdal L5121035_03520040910_B30.TIF out=lsat7_2004_30 --overwrite
r.in.gdal L5121035_03520040910_B40.TIF out=lsat7_2004_40 --overwrite
r.in.gdal L5121035_03520040910_B50.TIF out=lsat7_2004_50 --overwrite
r.in.gdal L5121035_03520040910_B60.TIF out=lsat7_2004_60 --overwrite
r.in.gdal L5121035_03520040910_B70.TIF out=lsat7_2004_70 --overwrite
g.list rast

# Image fusion with the IHS transformation

# apply a contrast stretch (histogram equal.) g.region rast=lsat7_2002_10 -p
r.colors lsat7_2004_10 color=grey.eq
r.colors lsat7_2004_20 color=grey.eq
r.colors lsat7_2004_30 color=grey.eq

# RGB view of RGB channels
d.mon wx0
d.erase
d.rgb b=lsat7_2004_10 g=lsat7_2004_20 r=lsat7_2004_30
d.text text="Landsat TM bands: 1-2-3" color=yellow size=2.5 font="Verdana Bold"
d.text text="Date: 2009-Sep-10" color=yellow size=2.5 font="Verdana Bold"

# IHS/RGB back conv. with ETMPAN replacing old intens. image
g.region rast=lsat7_2004_80 -p
i.his.rgb hue=hue intensity=lsat7_2004_80 \
saturation=sat blue=etm.1_15 green=etm.2_15 red=etm.3_15

# RGB/IHS conversion
i.rgb.his blue=lsat7_2002_10 green=lsat7_2002_20 \
red=lsat7_2002_30 hue=hue intensity=int saturation=sat
