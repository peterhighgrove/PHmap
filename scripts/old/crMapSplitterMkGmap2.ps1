# SEcont pid5000 - Sth, Nora, Öre, västerås, Etuna, Uppsala N59E14-19 (lon14-19lat59), Järvsö, Delsbo N61E16 (lon16lat61), Åre, Oviksfj N62-63E13 (lon13lat62-63)
# SEsthCont pid5100 - Boo, Viby, Gnesta, Ornö, Sandhamn, Norrtälje, uppsala, Enköping N59E17-18 (lon17-18lat59)
# SEbruksCont pid6100 - Bruks, Funäs, Hamra, N62E12 (lon12lat62)

# Pick up hgtFiles at https://drive.google.com/drive/folders/1CkcFqcXUic1e7tbVaDL7iMDMpsy9G2bM
# Create an area folder under C:\Users\peter\Documents\Maps Garmin\hgt\SONN\
# Use that as $area
# $date for the files
# Choose a unique $pidd (SEcont above needs 5000-5052)
#   Map pid SE=1000, FRlang=2000, FRalps=3000

#$country = "Sweden"
#$countryShort = "SE"
#$area = "SE"
#$areaSrcFilePrefix = "sweden"
#$descSuffix = ""
#$pidd = 1000
#$date = 240907
$country = "France"
$countryShort = "FR"
$area = "FRlang"
$areaSrcFilePrefix = "languedoc-roussillon"
$pidd = 2000
$date = 240907

$osmFolder = "C:\Users\peter\Documents\Maps Garmin\OSMsplitted"
$osmSplittedAreaFolder = $osmFolder         #Splitter do not allow to end with \

if (! (Test-Path -Path $osmSplittedAreaFolder)) {
     New-Item -ItemType Directory -Path $osmSplittedAreaFolder }
else {
    del ($osmSplittedAreaFolder + '\*') }

del "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
cd $osmSplittedAreaFolder

$srcFolder = "C:\Users\peter\Documents\Maps Garmin\OSMlatest\"
$srcFile = '"' + $srcFolder + $areaSrcFilePrefix + '-latest.osm.pbf"'

$javaArgs='-Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\Splitter\splitter.jar"'
$splitterArgs = ''
$splitterArgs = $splitterArgs + ' --output-dir="' + $osmSplittedAreaFolder + '"'
$splitterArgs = $splitterArgs + ' --mapid=6328' + $pidd
$splitterArgs = $splitterArgs + ' --description=' + $area + $descSuffix + '_' + $date + '_OSMtile'
# > ' + $area + 'splitter.log'
Write-Output $javaArgs
Write-Output $splitterArgs

Start-Process -FilePath "C:\Program Files (x86)\Common Files\Oracle\Java\java8path\Java.exe" -ArgumentList $javaArgs, $splitterArgsOutDir ,$splitterArgs, $srcFile -NoNewWindow -Wait

# From .BAT    java -Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\splitter\splitter.jar" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSMsplitted\SE" --mapid=63210001 --description=SE_240901_OSM_tile "C:\Users\peter\Documents\Maps Garmin\OSMlatest\sweden-latest.osm.pbf" > SEsplitter.log

$templateFile = $osmSplittedAreaFolder + "\template.args"
$javaArgs='-Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar"'
$mkGmapsArgs = ''
$mkGmapsArgs = $mkGmapsArgs + ' --transparent'
$mkGmapsArgs = $mkGmapsArgs + ' --generate-sea=multipolygon'
$mkGmapsArgs = $mkGmapsArgs + ' --add-pois-to-areas'
$mkGmapsArgs = $mkGmapsArgs + ' --country-name=' + $country
$mkGmapsArgs = $mkGmapsArgs + ' --country-abbr=' + $countryShort
$mkGmapsArgs = $mkGmapsArgs + ' --family-id=4000'
$mkGmapsArgs = $mkGmapsArgs + ' --family-name=PHmap'
$mkGmapsArgs = $mkGmapsArgs + ' --product-id=' + $pidd
$mkGmapsArgs = $mkGmapsArgs + ' --draw-priority=20'
$mkGmapsArgs = $mkGmapsArgs + ' --code-page=1252'
$mkGmapsArgs = $mkGmapsArgs + ' --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all"'
$mkGmapsArgs = $mkGmapsArgs + ' --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps"'
$mkGmapsArgs = $mkGmapsArgs + ' --gmapsupp'
$mkGmapsArgs = $mkGmapsArgs + ' -c "' + $templateFile + '"'
$mkGmapsArgs = $mkGmapsArgs + ' "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"'
$mkGmapsArgs = $mkGmapsArgs + ' --description=' + $area + $descSuffix + '_' + $date + '_PHmap' # need to be at the end to get the descr in file
Write-Output $javaArgs
Write-Output $mkGmapsArgs
#$mkGmapsArgs='--transparent --generate-sea=multipolygon --add-pois-to-areas --country-name=' + $country + ' --country-abbr=' + $countryShort + ' --family-id=4000 --family-name=PHmap --product-id=' + $pidd + ' --draw-priority=99 --code-page=1252 --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all" --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps" --gmapsupp -c "' + $templateFile + '" "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ" --description=' + $area + $descSuffix + '_PHmap_' + $date

Start-Process -FilePath "C:\Program Files (x86)\Common Files\Oracle\Java\java8path\Java.exe" -ArgumentList $javaArgs, $mkGmapsArgs -NoNewWindow -Wait

#Del ("C:\Users\peter\Documents\Maps Garmin\PHmaps\" + $area + "_PHmap_latest.img")
Move-Item -Path "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" -Destination ("C:\Users\peter\Documents\Maps Garmin\PHmaps\" + $area + $descSuffix + "_PHmap_latest.img") -Force
