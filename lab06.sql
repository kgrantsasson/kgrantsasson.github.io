/* Lab 6: Dar Es Salaam floodplain analysis with SQL*/ 
/* Using data from OpenStreetMaps, Ramania Huria (http://ramanihuria.org/), Resilience Academy (https://resilienceacademy.ac.tz/), we crafted SQL code that first creates a floodplain derived from OSM wetlands, and then subscribed area of subwards to determine which subwards had higher risk of flooding via percent area in the floodplain. */
/* Created by Tori Koontz and Kineret Grant-Sasson */

/* Identify all wetlands from imported OSM data, create new layer showing wetlands */
SELECT *
FROM planet_osm_polygon
WHERE "natural" = 'wetland' OR wetland IS NOT NULL 

/* transform wetlands layer*/
SELECT osm_id, ST_TRANSFORM(way, 32727) AS geom
FROM wetlands_all

/* Add table on wetlands layer for ward code for later joins */
ALTER TABLE wetlands_all ADD COLUMN Ward_Code Integer

/* Add table on wetlands layer for ward name */
ALTER TABLE wetlands_all ADD COLUMN Ward_Name text 

/* Run intersection between wetlands and subwards */

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

/* Calculate area of Subward and wetland layers*/

alter table subwards2 add column area_subward real;
update subwards2 set area_subward = st_area(geography(geom))

alter table intersect_wetlandwards add column area_wetland_insubward real;
update intersect_wetlandwards set area_wetland_insubward = st_area(geography(geom))

/* Calculate percent area of subwards that falls within floodplain*/

update subwards2
set pct_area = (area_wetland_insubward / area_subward * 100)
FROM intersect_wetlandwards
WHERE intersect_wetlandwards.fid = subwards2.fid 

/* Add Subward info (fid) to drain layer */

alter table drains add column subward real;
update drains
set subward = fid
from subwards2 
WHERE st_intersects(drains.geom, subwards2.geom) 

/* See count of storm drains in each subward: this doesn't join anything to the table but can be used in analysis*/

select count(subward) as subward_count, subward 
from drains 
group by subward 

create view subwardcount1 as 
select count(subward) as subward_count, subward
from drains 
group by subward 

/* Add count to subward table */ 

alter table subwards2 add column draincount integer;

update subwards2 
set draincount = subward_count 
from subwardcount1
where subwardcount1.subward =subwards2.fid 

/*Join pct of area in floodplain info to subwards layer*/
update subwards2
set floodplain_pct = pct_area
from intersect_wetlandwards 
WHERE intersect_wetlandwards.fid = subwards2.fid 

/* we done!*/

