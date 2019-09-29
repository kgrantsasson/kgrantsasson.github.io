In this lab, we created a hydrological flow model for the Kilimanjaro region.

First, we downloaded a Digital Elevation Model (DEM) from EarthData. I chose to use data collected by NASA Shuttle Radar Topography Mission (STRM). 

![Kilamanjaro DEM](DEM.PNG) 

After using the Proj4 tool to project the DEM, I performed a hillshade analyses in order to view the elevation changes in the terrain more clearly.

![Hillshade Analyses](Analytical Hillshade.PNG) 

Next, I used the Sink Drainage Route tool to detect sinks (real or in the form of data holes) in the landscapes to prevent my hydrological analyses from taking those into acount. 

![Sinkhole Routes](Sink Route.PNG)

Aftet establishing where sink holes existed in the data, I "filled" them using the Sink Removal Tool. Then I was able to use the Flow Accumulation (Top-Down) to determine where the water will go. The dark blue lines indicate river heads where waters from many locations meet.

![Flow Accumulation](Flow Accumulation.PNG) 

Finally, I used the Channel Network tool to define where the streams are/will be in the region.

![Channel Network](Channel Network.PNG)

Here is an image of the expected flows, designated with color for direction.

![Channel Direction](Channel Direction.PNG) 
