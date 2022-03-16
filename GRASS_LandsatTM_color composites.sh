#!/bin/sh
# GRASS GIS script for processing and visualizing Landsat TM image.
# Region: Qingdao, China.

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

# 1-2-3 RGB near-natural color composite of LANDSAT-TM7 scene of 2009:
g.region rast=lsat7_2009_10 -p
# visual inspection
d.mon wx0
d.erase
d.rgb b=lsat7_2009_10 g=lsat7_2009_20 r=lsat7_2009_30
d.text text="Landsat TM bands: 1-2-3" color=yellow size=2.5 font="Verdana Bold"
d.text text="Date: 2009-May-19" color=yellow size=2.5 font="Verdana Bold"

# 5-4-3- False color composite of LANDSAT-TM7 scene of 2009:
g.region rast=lsat7_2009_10 -p
# visual inspection
d.mon wx0
d.erase
d.rgb b=lsat7_2009_50 g=lsat7_2009_40 r=lsat7_2009_30
d.text text="Landsat TM bands: 5-4-3" color=yellow size=2.5 font="Verdana Bold"
d.text text="Date: 2009-May-19" color=yellow size=2.5 font="Verdana Bold"

# 2-3-4 color composite of LANDSAT-TM7 scene of 2009:
g.region rast=lsat7_2009_10 -p
# visual inspection
d.mon wx0
d.erase
d.rgb b=lsat7_2009_20 g=lsat7_2009_30 r=lsat7_2009_40
d.text text="Landsat TM bands: 2-3-4" color=yellow size=2.5 font="Verdana Bold"
d.text text="Date: 2009-May-19" color=yellow size=2.5 font="Verdana Bold"

# 4-5-6 color composite of LANDSAT-TM7 scene of 2009:
g.region rast=lsat7_2009_10 -p
# visual inspection
d.mon wx0
d.erase
d.rgb b=lsat7_2009_40 g=lsat7_2009_50 r=lsat7_2009_70
d.text text="Landsat TM bands: 4-5-7" color=yellow size=2.5 font="Verdana Bold"
d.text text="Date: 2009-May-19" color=yellow size=2.5 font="Verdana Bold"

# 5-6-7 color composite of LANDSAT-TM7 scene of 2009:
g.region rast=lsat7_2009_10 -p
# visual inspection
d.mon wx0
d.erase
d.rgb b=lsat7_2009_50 g=lsat7_2009_60 r=lsat7_2009_70
d.text text="Landsat TM bands: 5-6-7" color=yellow size=2.5 font="Verdana Bold"
d.text text="Date: 2009-May-19" color=yellow size=2.5 font="Verdana Bold"

# 5-4-3 color composite of LANDSAT-TM7 scene of 2009:
g.region rast=lsat7_2009_10 -p
# visual inspection
d.mon wx0
d.erase
d.rgb b=lsat7_2009_50 g=lsat7_2009_40 r=lsat7_2009_30
d.text text="Landsat TM bands: 5-4-3" color=yellow size=2.5 font="Verdana Bold"
d.text text="Date: 2009-May-19" color=yellow size=2.5 font="Verdana Bold"
