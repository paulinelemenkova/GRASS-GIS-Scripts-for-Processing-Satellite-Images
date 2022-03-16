#!/bin/sh
# GRASS GIS script for processing and visualizing Landsat TM image. Region: Qingdao, China.
gdalinfo L5121035_03520040910_B10.TIF
# import the image subset and display the raster map
r.in.gdal L5121035_03520040910_B10.TIF out=lsat7_2004_10
r.in.gdal L5121035_03520040910_B20.TIF out=lsat7_2004_20
r.in.gdal L5121035_03520040910_B30.TIF out=lsat7_2004_30
r.in.gdal L5121035_03520040910_B40.TIF out=lsat7_2004_40
r.in.gdal L5121035_03520040910_B50.TIF out=lsat7_2004_50
r.in.gdal L5121035_03520040910_B60.TIF out=lsat7_2004_60
r.in.gdal L5121035_03520040910_B70.TIF out=lsat7_2004_70
g.list rast

# Land Surface Temperature map
# convert TM5/B6 digital numbers (DN) to spectral radiances
# (apparent radiance at sensor): radiance = gain * DN + offset
d.mon wx0
g.region rast=lsat7_2004_60 -p
d.erase
# show metadata
r.info lsat7_2004_60

r.mapcalc "lsat7_2004_60.rad=0.0551584*lsat7_2004_60+1.2378" --overwrite
r.info -r lsat7_2004_60.rad
#min=1.2378
#max=11.3317872

# convert spectral radiances to absolute temperatures # T = K2/ln(K1/L_l + 1))
r.mapcalc "tm7.temp_kelvin_2004=1260.56 /(log (607.76/lsat7_2004_60.rad + 1.))" --overwrite
r.info -r tm7.temp_kelvin_2004

# convert to degree Celsius
r.mapcalc "tm7.temp_celsius_2004=tm7.temp_kelvin_2004 - 273.15" --overwrite
r.info -r tm7.temp_celsius_2004
r.univar tm7.temp_celsius_2004

# apply new color table and display
r.colors tm7.temp_celsius_2004 col=bgyr
d.rast tm7.temp_celsius_2004
d.legend raster=tm7.temp_celsius_2004 range=0,40 title=Surface_temp,grad title_fontsize=8 font="Times New Roman" fontsize=8 -t -b bgcolor=white label_step=5 border_color=gray thin=8
