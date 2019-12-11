SET PATH=%PATH%;c:\saga6
SET pre=SRTMDEM
SET od=W:\OpenSource\lab04\SRTMmapstuff\%pre%data
if not exist %od% mkdir %od%

saga_cmd grid_tools 3 -GRIDS=W:\OpenSource\lab04\SRTMDEMs\S03E037.hgt;W:\OpenSource\lab04\SRTMDEMs\S04E037.hgt -NAME=%pre%Mosaic -TYPE=9 -RESAMPLING=0 -OVERLAP=1 -MATCH=0 -TARGET_OUT_GRID=%od%\%pre%mosaic.sgrd

saga_cmd pj_proj4 24 -SOURCE=%od%\%pre%mosaic.sgrd -RESAMPLING=0 -KEEP_TYPE=1 -GRID=%od%\%pre%mosaicUTM.sgrd -UTM_ZONE=37 -UTM_SOUTH=1

saga_cmd ta_lighting 0 -ELEVATION=%od%\%pre%mosaicUTM.sgrd -SHADE=%od%\%pre%hillshade.sgrd -METHOD=0 -POSITION=0 -AZIMUTH=315.000000 -DECLINATION=45.000000 -DATE=2019-10-07 -TIME=12.000000 -EXAGGERATION=1.000000 -UNIT=0 -SHADOW=0 -NDIRS=8 -RADIUS=10.000000 -ELEVATION=%od%\%pre%mosaic.sgrd -SHADE=%od%\%pre%hillshade.sgrd 

saga_cmd ta_preprocessor 1 -ELEVATION=%od%\%pre%mosaicUTM.sgrd -SINKROUTE=%od%\%pre%Sinkroute.sgrd -THRESHOLD=0 -THRSHEIGHT=100.000000

saga_cmd ta_preprocessor 2 -DEM=%od%\%pre%mosaicUTM.sgrd -SINKROUTE=%od%\%pre%Sinkroute.sgrd -DEM_PREPROC=%od%\%pre%Sinksremoved.sgrd -METHOD=1 -THRESHOLD=0 -THRSHEIGHT=100.000000

saga_cmd ta_hydrology 0 -ELEVATION=%od%\%pre%Sinksremoved.sgrd -SINKROUTE=%od%\%pre%Sinkroute.sgrd -WEIGHTS=NULL -FLOW=%od%\%pre%flowaccumulation.sgrd -VAL_INPUT=NULL -ACCU_MATERIAL=NULL -STEP=1 -FLOW_UNIT=0 -FLOW_LENGTH=NULL -LINEAR_VAL=NULL -LINEAR_DIR=NULL -METHOD=4 -LINEAR_DO=1 -LINEAR_MIN=500 -CONVERGENCE=1.100000

saga_cmd ta_channels 0 -ELEVATION=%od%\%pre%Sinksremoved.sgrd -SINKROUTE=%od%\%pre%Sinkroute.sgrd -CHNLNTWRK=%od%\%pre%channelnetwork.sgrd -CHNLROUTE=%od%\%pre%channelroute.sgrd -SHAPES=%od%\%pre%shapes.shp -INIT_GRID=%od%\%pre%flowaccumulation.sgrd -INIT_METHOD=2 -INIT_VALUE=1000 -DIV_GRID=NULL -DIV_CELLS=5 -TRACE_WEIGHT=NULL -MINLEN=10

ECHO Processing Complete!
PAUSE  
