del "C:\Users\peter\Documents\Maps Garmin\OSMlatest\SrtmBoo.osm"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SEcont\*"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo ======="" ""
::"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 5 -cat 20 10 -bounds3 "https://www.openstreetmap.org/way/17661546#map=12/59.4821/15.0599" -bounds3 "https://www.openstreetmap.org/way/17661546#map=12/59.2959/18.3166" -bounds3 "https://www.openstreetmap.org/query?lat=43.627191&lon=3.006155#map=13/43.61147/3.01128" -bounds3 "https://www.openstreetmap.org/#map=12/45.8427/6.2148" -bounds3 "https://www.openstreetmap.org/#map=10/63.1190/13.1836" -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\SrtmBoo.osm"
"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 5 -cat 50 25 -bounds1 11.03 55.36 23.9 69.11 -bounds3 "https://www.openstreetmap.org/#map=13/43.61147/2.98124" -bounds3 "https://www.openstreetmap.org/#map=12/45.8427/6.2148" -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\SrtmBoo.osm"
pause
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SEcont" --mapid=63240001 --description=SEFRcont_240831_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\SrtmBoo.osm"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
::"C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SEcont\63240001.osm.pbf"
Java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --transparent --generate-sea=multipolygon --add-pois-to-areas --country-name=Sweden --country-abbr=SE --family-id=4000 --family-name=PHmap --product-id=4000 --draw-priority=99 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SEcont\template.args" --description=SEFRcont_PHmap_240831 "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\SEFRcont_PHmap_latest.img
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
rd /Q/S "C:\Users\peter\Documents\Maps Garmin\PHmap\srtm"
::"C:\Program Files\Syncovery\Syncovery.exe" /RUNX="GarminMapsToWatch" /O