This week, we expanded our work in lab 3 by using a cammand prompt batch process to complete the hydrological workflow for Kilamanjaro, Tanzania. This week however, we used both ASTER and SRTM data and compared the number (error) files in order to determine which data collection system is more accurate for particular landscapes.

First, we mosaicked the DEMS and projected them into the correct coordinate system (UTM Zone 37) from the WGS projection. I then applied a hillshade with azimuth 315 and height 45 in order to better visualize the terrain.

![Analytical Hillshade](hillshade.PNG)

Next I established where the sinks are in the terrain so that they could be filled for a more accurate hydrological model.

![sink route](sinkroute.PNG) 

Finally, I ran flow accumualation tool. As you can see below, darker areas are areas with greater flow accumulation. Once this value reaches a certain threshold, we can determine that there is a stream present.

![Flow Accumulation](flowaccumulation.PNG) 

The batch process method is helpful because one could theorhetically run the model without even having a gis open on their computer. Additionally, the user can simply switch out inputs for different data sources or geographical regions. Running the number files and then subtracting them from each other is an important step in interrogating your data sources and rooting out error propogation. These programs (ASTER and STRM) work by collecting data from particular locations at varying angles and positions. Some areas are harder to capture than others, which forces the collector to source data from other places or interpolate data from nearby areas. 

Here is the output of subtracting ASTER from SRTM. Where the pixels are more blue or more red, there is more inconsistancy between the two data sources. The areas that are whiter demonstrate more agreement and therefore cerainty. As you can see by comparing the following two images with the hillshade, the areas of greater uncertainty are in the higher elevations. There is a area of marked uncertainty at the lake on the base of the mountain. This may be because it is very hard for ASTER and SRTM to determine direction of flow or elevation on the lake's surface.

![Difference in Flow Accumulation](differenceflow.PNG) 

Below is the output for the differences in the ASTER and SRTM Digital Elevation Models.

![Difference in DEMS](differenceDEM).PNG

