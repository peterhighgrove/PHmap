chcp 65001
::Sweden 
:: splitter --max-nodes=1550000
:: mkgmap --max-jobs=12
::java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SE" --mapid=63210001 --description=SE_240804_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\sweden-latest.osm.pbf" > SEsplitter.log
Java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --generate-sea=multipolygon --add-pois-to-areas --country-name=Sweden --country-abbr=SE --family-id=4000 --family-name=PHmap --product-id=1000 --draw-priority=21 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SE\template.args" --description=SE_PHmap_240804-phTyp25 "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ" > SEmkGmap.log

move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\SE_PHmap_latest_phTyp25.img"
copy "C:\Users\peter\Documents\Maps Garmin\PHmaps\SE_PHmap_latest_phTyp25.img" "C:\Users\peter\OneDrive\Dokument Peter OneDrive\Träning\Maps Garmin IMG\PHmaps"

::France Languedoc
::java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\FRld" --mapid=63220001 --description=FRld_240804_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\languedoc-roussillon-latest.osm.pbf" > FRldsplitter.log
java -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --generate-sea=multipolygon --add-pois-to-areas --country-name=France --country-abbr=FR --region-name=Languedoc --region-abbr=ld --family-id=4000 --family-name=PHmap --product-id=2000 --draw-priority=21 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\FRld\template.args" --description=FRld_PHmap_240804-phTyp25 "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ" > FRldMKGmap.log

move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\FRld_PHmap_latest_phTyp25.img"
copy "C:\Users\peter\Documents\Maps Garmin\PHmaps\FRld_PHmap_latest_phTyp25.img" "C:\Users\peter\OneDrive\Dokument Peter OneDrive\Träning\Maps Garmin IMG\PHmaps"

::France Rhone-Alpes
::java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\FRra" --mapid=63230001 --description=FRra_240805_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\rhone-alpes-latest.osm.pbf" > FRrasplitter.log
java -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar" --generate-sea=multipolygon --add-pois-to-areas --country-name=France --country-abbr=FR --region-name=Rhone-Alpes --region-abbr=ra --family-id=4000 --family-name=PHmap --product-id=3000 --draw-priority=21 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "C:\Users\peter\Documents\Maps Garmin\OSMsplitted\Frra\template.args" --description=FRra_PHmap_240805-phTyp25 "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ" > FRraMKGmap.log

move /Y "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" "C:\Users\peter\Documents\Maps Garmin\PHmaps\FRra_PHmap_latest_phTyp25.img"
copy "C:\Users\peter\Documents\Maps Garmin\PHmaps\FRra_PHmap_latest_phTyp25.img" "C:\Users\peter\OneDrive\Dokument Peter OneDrive\Träning\Maps Garmin IMG\PHmaps"

"C:\Program Files\Syncovery\Syncovery.exe" /RUNX="GarminMapsToWatch" /O
