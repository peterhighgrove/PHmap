<#
 Download osm datafiles
 Save to $srcFolder = "C:\Users\peter\Documents\Maps Garmin\OSMlatest\"
 File need to end with  '-latest.osm.pbf"'
 File start with $areaSrcFilePrefix
 $srcFile = '"' + $srcFolder + $areaSrcFilePrefix + '-latest.osm.pbf"'
 $area is the short descript
 $date for the files
 Choose a unique $pidd (SEcont above needs 5000-5052)
   Map pid SE=1000, FRlang=2000, FRalps=3000
 
 SE pid1000
 FRlang pid2000
 FRalps pid3000
#>

#<#
$areaSrcFilePrefix = "sweden"
$country = "Sweden"
$countryShort = "SE"
$area = "SEall"
$descSuffix = ""
$pidd = 1000
$date = 240907
#>
<#
$areaSrcFilePrefix = "languedoc-roussillon"
$country = "France"
$countryShort = "FR"
$area = "FRlang"
$descSuffix = ""
$pidd = 2000
$date = 240907
#>
<#
$areaSrcFilePrefix = "rhone-alpes"
$country = "France"
$countryShort = "FR"
$area = "FRalps"
$descSuffix = ""
$pidd = 3000
$date = 240805
#>

$osmFolder = "C:\Users\peter\Documents\Maps Garmin\OSMsplitted"
$osmSplittedAreaFolder = $osmFolder         #Splitter do not allow to end with \

if (! (Test-Path -Path $osmSplittedAreaFolder)) {
     New-Item -ItemType Directory -Path $osmSplittedAreaFolder }
else {
    del ($osmSplittedAreaFolder + '\*') }

del "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
#cd $osmSplittedAreaFolder  # Only needed for pyHgtMap

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

Start-Process -FilePath "C:\Program Files (x86)\Common Files\Oracle\Java\java8path\Java.exe" -ArgumentList $javaArgs, $splitterArgs, $srcFile -NoNewWindow -Wait

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
Copy-Item -Path ("C:\Users\peter\Documents\Maps Garmin\PHmaps\" + $area + $descSuffix + "_PHmap_latest.img") -Destination ("C:\Users\peter\OneDrive\Dokument Peter OneDrive\Träning\Maps Garmin IMG\PHmaps") -Force
