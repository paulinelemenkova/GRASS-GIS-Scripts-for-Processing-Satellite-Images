#!/bin/sh
# GRASS GIS script for processing and visualizing Landsat TM image. Region: Qingdao, China.
gdalinfo L5121035_03520090519_B10.TIF
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

# Land Surface Temperature map
# convert TM5/B6 digital numbers (DN) to spectral radiances
# (apparent radiance at sensor): radiance = gain * DN + offset
g.region rast=lsat7_2009_60 -p
# show metadata
r.info lsat7_2009_60

r.mapcalc "lsat7_2009_60.rad=0.0551584*lsat7_2009_60+1.2378" --overwrite
r.info -r lsat7_2009_60.rad
#min=1.2378
#max=12.3797968

# convert spectral radiances to absolute temperatures # T = K2/ln(K1/L_l + 1))
r.mapcalc "tm7.temp_kelvin=1260.56 /(log (607.76/lsat7_2009_60.rad + 1.))" --overwrite
r.info -r tm7.temp_kelvin

# convert to degree Celsius
r.mapcalc "tm7.temp_celsius=tm7.temp_kelvin - 273.15" --overwrite
r.info -r tm7.temp_celsius
r.univar tm7.temp_celsius

# apply new color table and display
r.colors tm7.temp_celsius col=bgyr
d.rast tm7.temp_celsius
d.legend raster=tm7.temp_celsius range=0,40 title=Surface_temp,grad title_fontsize=8 font="Times New Roman" fontsize=8 -t -b bgcolor=white label_step=5 border_color=gray thin=8
