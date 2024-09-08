echo =======
echo =========================================================================================================
echo =========================================================================================================
echo ======="" ""
set area=SEcontSONN
set date=240903
set pid=5000
cd C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%
pause
::"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 5 -cat 50 25 -bounds1 59.663543 17.481581 59.138069 18.758333 -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
::pyhgtmap --step=5 --line-cat=50,25 --pbf hgt\SONN\N59E014.hgt hgt\SONN\N59E015.hgt hgt\SONN\N59E016.hgt hgt\SONN\N59E017.hgt hgt\SONN\N59E018.hgt hgt\SONN\N59E019.hgt hgt\SONN\N61E016.hgt hgt\SONN\N62E013.hgt hgt\SONN\N63E013.hgt 
::java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%" --mapid=632%pid%1 --description=%area%_%date%_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\lon*.osm.pbf"
Java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --transparent --generate-sea=multipolygon --add-pois-to-areas --country-name=Sweden --country-abbr=SE --family-id=4000 --family-name=PHmap --product-id=%pid% --description=%area%_PHmap_%date% --draw-priority=99 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\template.args" "C:\Users

\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"
pause
move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\%area%_PHmap_latest.img
pause
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\*"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMlatest\*.osm"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
rd /Q/S "C:\Users\peter\Documents\Maps Garmin\srtm"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
::"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 2 -cat 50 10 -bounds3 "https://www.openstreetmap.org/query?lat=43.627191&lon=3.006155#map=13/43.61147/3.01128" -bounds3 "https://www.openstreetmap.org/#map=12/45.8427/6.2148" -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\SrtmBoo.osm"
::"C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SEcont\63240001.osm.pbf"
set area=FRcontLangAnne
set date=240902
set pid=7000
"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 10 -cat 250 50 -bounds3 "https://www.openstreetmap.org/query?lat=43.627191&lon=3.006155#map=13/43.61147/3.01128" -bounds3 "https://www.openstreetmap.org/#map=12/45.8427/6.2148" -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%" --mapid=632%pid%1 --description=%area%_%date%_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
Java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --transparent --generate-sea=multipolygon --add-pois-to-areas --country-name=France --country-abbr=FR --family-id=4000 --family-name=PHmap --product-id=%pid% --draw-priority=99 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\template.args" --description=%area%_PHmap_%date% "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"
move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\%area%_PHmap_latest.img
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\*"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMlatest\*.osm"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
rd /Q/S "C:\Users\peter\Documents\Maps Garmin\srtm"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
set area=SEcontSth
set date=240902
set pid=4000
"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 5 -cat 50 25 -bounds1 59.663543 17.481581 59.138069 18.758333 -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%" --mapid=632%pid%1 --description=%area%_%date%_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
Java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --transparent --generate-sea=multipolygon --add-pois-to-areas --country-name=Sweden --country-abbr=SE --family-id=4000 --family-name=PHmap --product-id=%pid% --draw-priority=99 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\template.args" --description=%area%_PHmap_%date% "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"
move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\%area%_PHmap_latest.img
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\*"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMlatest\*.osm"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
rd /Q/S "C:\Users\peter\Documents\Maps Garmin\srtm"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
set area=SEcontNoraOre
set date=240902
set pid=5000
"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 5 -cat 50 25 -bounds1 59.869662 14.426766 59.167400 15.457764 -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%" --mapid=632%pid%1 --description=%area%_%date%_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
Java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --transparent --generate-sea=multipolygon --add-pois-to-areas --country-name=Sweden --country-abbr=SE --family-id=4000 --family-name=PHmap --product-id=%pid% --draw-priority=99 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\template.args" --description=%area%_PHmap_%date% "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"
move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\%area%_PHmap_latest.img
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\*"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMlatest\*.osm"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
rd /Q/S "C:\Users\peter\Documents\Maps Garmin\srtm"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
set area=SEcontJarvso
set date=240902
set pid=6000
"C:\Users\peter\Documents\Maps Garmin\Srtm2Osm\Srtm2Osm.exe" -step 5 -cat 50 25 -bounds1 61.782343 15.873027 61.533125 16.830404 -o "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%" --mapid=632%pid%1 --description=%area%_%date%_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\%area%.osm"
Java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --transparent --generate-sea=multipolygon --add-pois-to-areas --country-name=Sweden --country-abbr=SE --family-id=4000 --family-name=PHmap --product-id=%pid% --draw-priority=99 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\template.args" --description=%area%_PHmap_%date% "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"
move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\%area%_PHmap_latest.img
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\%area%\*"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSMlatest\*.osm"
del /Q "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
rd /Q/S "C:\Users\peter\Documents\Maps Garmin\srtm"
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
echo =======
echo =========================================================================================================
echo =========================================================================================================
echo =======
::"C:\Program Files\Syncovery\Syncovery.exe" /RUNX="GarminMapsToWatch" /O