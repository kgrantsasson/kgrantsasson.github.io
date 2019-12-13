# Flood Risk in Dar Es Salaam 

This week, I sourced data from Open Street Map and Resilience Academy to determine the proportion of each subward in Dar es Salaam that lies in a floodplain.

Dar es Salaam is one of the most mapped cities in the world, so we are able to take advantage of the wealth of qualitative and quantitaive, locally-collected and analyzed data to start creating our own models of urban resilience. We used SQL, or ‘structured query language’, which relies on short command lines of code which tell the computer programs how you want your data managed, transformed, and analyzed. We choose to find what percentage of each subward lies in a floodplain, one indicator that can help to determine which subwards are at the greatest risk of flooding. Below is the step-by-step processes for this lab:

## Methods 

We began by downloading data from Ramania Huria’s “Resilience Academy” project: https://resilienceacademy.ac.tz/ for Dar Es Salaam. 

Next, we needed to create a layer that would represent the floodplain, since one did not exist in the Resilience Academy database. We were able to do this by pulling in Open Street Map data (Quick OSM search in QGIS, available as a plugin). For more information about how you can use Open Street Maps in QGIS, check out https://docs.qgis.org/QGIS-Documentation-2.2/live/html/en/docs/user_manual/osm/openstreetmap.html

For our project, we performed a Quick OSM search for all OSM features tagged “wetland” and added those to our map, making sure to first transform them to the correct Coordinate Reference System (CRS). We then added an identification column ("ward name") to make a spatial joins with the subward layer. This is documented in the first few steps of our SQL code, accessible on this page. 

Then we itersected the wetlands layer with the subwards layer in order to determine in which subward the floodplain fell. This part was the trickiest for us to implement using SQL code and it can seem quite confusing, so we recommend using online tutorials and other resources to better understand the SQL functions at work here.

Here is the SQL we used for this step:

CREATE TABLE intersect_wetlandwards AS 
SELECT a.osm_id,wetland, b.fid,ward_name,
CASE
WHEN ST_CoveredBy(a.way, b.geom)
THEN ST_Multi(a.way)
ELSE
ST_Multi( ST_Intersection(a.way,b.geom) ) END AS geom
FROM wetlands_all AS a
INNER JOIN subwards2 AS b
ON (ST_Intersects(a.way, b.geom)
AND NOT ST_Touches(a.way, b.geom) )

Next, we calculated the area of subwards and then the area of the floodplain in each subward using the st_area function in SQL. It’s a fairly straightforward function which calculates the area of given geometries, which can then be put in either the subward or floodplain tables. For the later purposes of visual representation/mapping, I recommend working on the Subwards layer. However, note how it is possible to pull information from other tables to use in SQL queries within another table, which is what we did for the final combination.

Finally, we calculated the percent of wetland area in each subward using a simple calculation in SQL; we were interested in vizualizing this as a primary factor of risk in flooding.

### Visualization 

After finishing our spatial analyses in Q we worked the interacting mapping tool Leaflet to create an interactive web visualization. Leaflet is a user-friendly program which allows the user to present your analysis and then post it to easily-accesible web pages to make sharing your work that much simpler. We used the GIS2Web plugin in Q to upload our map. An important note: any vizualizations you’ve created in QGIS, like color schemes, will not automatically enter in to the html code created by the Leaflet plugin. You will need to edit the given HTML code to add all the information you want into the map. In addition to that, there are numerous other features you can write into the script to create your desired map output. Check out https://leafletjs.com/reference-1.5.0.html for more information.

### Results

Our map identifies the subwards that have the greatest proportion of their area in a floodplain. We used this indicator to determine which subwards are most at risk for flooding. According to our analyses, 

[Click Here](/NEWdsmmap/index.html) to access my leaflet map of Dar es Salaam subwards ranked by the percent of subward area in a floodplain. I've also included a point layer of storm drains for reference. 

[Click Here](lab06.sql) to access the sql code I used to build my map. 

