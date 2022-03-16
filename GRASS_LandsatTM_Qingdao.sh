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

#
g.region rast=lsat7_2009_10 -p
r.info lsat7_2009_10
d.mon wx0
d.erase
# show DEM
d.rast lsat7_2009_DEM
# show 30m LANDSAT-TM7 channel
d.rast lsat7_2009_70
# histogram
d.histogram lsat7_2009_DEM
d.histogram lsat7_2002_80
#
d.erase
d.correlate map=lsat7_2009_10,lsat7_2009_20
d.correlate map=lsat7_2009_30,lsat7_2009_40
d.correlate map=lsat7_2009_50,lsat7_2009_70
#d.correlate map=lsat7_2009_30,lsat7_2009_70
d.correlate map=lsat7_2009_40,lsat7_2009_70
d.text text="A): lsat7_2009_10,lsat7_2009_20" color='0:0:51' size=3.0 font=Arial
d.text text="B): lsat7_2009_30,lsat7_2009_40" color='0:0:51' size=3.0 font=Arial
d.text text="C): lsat7_2009_50,lsat7_2009_70" color='0:0:51' size=3.0 font=Arial
d.text text="B): lsat7_2009_50,lsat7_2009_70" color='0:0:51' size=3.0 font=Arial
d.text text="D): lsat7_2009_40,lsat7_2009_70" color='0:0:51' size=3.0 font=Arial


#To apply a gain/bias correction, the module r.mapcalc can be used. For our example, we use the LANDSAT-TM7 scene of 2009:
g.region rast=lsat7_2009_10 -p
# visual inspection
d.erase
d.rgb b=lsat7_2009_10 g=lsat7_2009_20 r=lsat7_2009_30
# show metadata
r.info lsat7_2009_10

# convert pixel values to radiances: see p016r035_7x20020524.met # LMAX_BAND1=19
# LMIN_BAND1=-6.200
# QCALMAX_BAND1=255.0
# QCALMIN_BAND1=1.0
# QCAL is the quantized calibrated pixel value in DN
r.mapcalc "lsat7_2009_10.rad= ((19.0 - (-6.2))/(255.0 - 1.0)) \
    * (lsat7_2009_10 - 1.0) + (-6.2)"
r.info -r lsat7_2009_10.rad
min=-6.2992125984252
max=19



# rename channels or make a copy to match i.landsat.toar's input scheme:
g.copy raster=lsat7_2009_10,lsat7_2009.1
g.copy raster=lsat7_2009_20,lsat7_2009.2
g.copy raster=lsat7_2009_30,lsat7_2009.3
g.copy raster=lsat7_2009_40,lsat7_2009.4
g.copy raster=lsat7_2009_50,lsat7_2009.5
g.copy raster=lsat7_2009_60,lsat7_2009.6
g.copy raster=lsat7_2009_70,lsat7_2009.7
# Delete all raster maps starting with "lsat7_2009." in the current mapset
g.remove -f type=raster pattern="lsat7_2009.*"


# convert TM5/B6 digital numbers (DN) to spectral radiances
# (apparent radiance at sensor): radiance = gain * DN + offset g.region rast=lsat5_1987_60 -p
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

# apply new color table, display
r.colors tm7.temp_celsius col=bgyr
d.rast tm7.temp_celsius
d.legend raster=tm7.temp_celsius range=0,40 title=Surface_temp,grad title_fontsize=8 font="Times New Roman" fontsize=8 -t -b bgcolor=white label_step=5 border_color=gray thin=8
