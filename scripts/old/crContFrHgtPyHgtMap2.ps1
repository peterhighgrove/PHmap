# SEcont pid5000 - Sth, Nora, Öre, västerås, Etuna, Uppsala N59E14-19 (lon14-19 lat59), Järvsö, Delsbo N61E16 (lon16 lat61), Åre, Oviksfj N62-63E13 (lon13 lat62-63)
# SEsthCont pid5100 - Boo, Viby, Gnesta, Ornö, Sandhamn, Norrtälje, uppsala, Enköping N59E17-18 (lon17-18lat59)
# SEbruksCont pid5200 - Bruks, Funäs, Hamra, N62E12 (lon12lat62)
# FRlang pid6000 6100

# Pick up hgtFiles at https://drive.google.com/drive/folders/1CkcFqcXUic1e7tbVaDL7iMDMpsy9G2bM
# Create an area folder under C:\Users\peter\Documents\Maps Garmin\hgt\SONN\
# Use that as $area
# $date for the files
# Choose a unique $pidd (SEcont above needs 5000-5052)
# Contour config sweden "--step=5 --line-cat=50,25 --pbf"
# Contour config mountains "--step=10 --line-cat=250,50 --pbf"

cd "C:\Users\peter\OneDrive\Dokument Peter OneDrive\Träning\Maps Garmin IMG\PHmaps"
Pause

$country = "Sweden"
$countryShort = "SE"
$area = "SECont"
$descSuffix = ""
$pidd = 5000
$date = 240903
$contourStep = 5
$contourMinor = 25
$contourMajor = 50
#$pyHgtMapArgs = "--step=10 --line-cat=250,50 --no-zero-contour --pbf"

$osmFolder = "C:\Users\peter\Documents\Maps Garmin\OSMsplitted"
$osmSplittedAreaFolder = $osmFolder

if (! (Test-Path -Path $osmSplittedAreaFolder)) {
     New-Item -ItemType Directory -Path $osmSplittedAreaFolder}
else {
    del ($osmSplittedAreaFolder + '\*')}

del "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\*"
cd $osmSplittedAreaFolder

$pyHgtMapArgs = ''
$pyHgtMapArgs = $pyHgtMapArgs + ' --step=' + $contourStep
$pyHgtMapArgs = $pyHgtMapArgs + ' --line-cat=' + $contourMajor + ',' + $contourMinor 
$pyHgtMapArgs = $pyHgtMapArgs + ' --no-zero-contour'
$pyHgtMapArgs = $pyHgtMapArgs + ' --pbf'

$hgtFolder = "C:\Users\peter\Documents\Maps Garmin\hgt\SONN\" + $area + "\"
$hgtFilter = $hgtFolder + "*.hgt"
$hgtFiles = ( Get-ChildItem -Path $hgtFilter ).FullName -join '" "'
$hgtFiles = '"' + $hgtFiles + '"'
Write-Output $pyHgtMapArgs
Write-Output $hgtFiles

Start-Process -FilePath "C:\Users\peter\AppData\Local\Programs\Python\Python311\Scripts\pyHgtMap.exe" -ArgumentList $pyHgtMapArgs, $hgtFiles  -NoNewWindow -Wait

# Please note that dir is an alias for Get-ChildItem and ForEach is an alias for ForEach-Object.

$osmFilter = $osmSplittedAreaFolder + "\*.osm.pbf"
$templateFile = $osmSplittedAreaFolder + "\template.args"
$i = $pidd

dir $osmFilter | ForEach {
    $i = $i + 1
    $variable = "mapname: 6328" + $i + "`n" + "description: " + $area + "_" + $date + "_OSMtile" + "`n" + "input-file: $($_.Name)`n"
    #Write-Output $variable
    Add-Content -Value $variable -Path $templateFile
}

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
$mkGmapsArgs = $mkGmapsArgs + ' --draw-priority=99'
$mkGmapsArgs = $mkGmapsArgs + ' --code-page=1252'
$mkGmapsArgs = $mkGmapsArgs + ' --style-file="C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all"'
$mkGmapsArgs = $mkGmapsArgs + ' --output-dir="C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps"'
$mkGmapsArgs = $mkGmapsArgs + ' --gmapsupp'
$mkGmapsArgs = $mkGmapsArgs + ' -c "' + $templateFile + '"'
$mkGmapsArgs = $mkGmapsArgs + ' "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"'
$mkGmapsArgs = $mkGmapsArgs + ' --description=' + $area + $descSuffix + '_' + $date + '_PHmap' # need to be at the end to get the descr in file
Write-Output $javaArgs
Write-Output $mkGmapsArgs

Start-Process -FilePath "C:\Program Files (x86)\Common Files\Oracle\Java\java8path\Java.exe" -ArgumentList $javaArgs, $mkGmapsArgs -NoNewWindow -Wait

#Del ("C:\Users\peter\Documents\Maps Garmin\PHmaps\" + $area + "_PHmap_latest.img")
Move-Item -Path "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps\gmapsupp.img" -Destination ("C:\Users\peter\Documents\Maps Garmin\PHmaps\" + $area + $descSuffix + "_PHmap_latest.img") -Force
Copy-Item -Path ("C:\Users\peter\Documents\Maps Garmin\PHmaps\" + $area + $descSuffix + "_PHmap_latest.img") -Destination ("C:\Users\peter\OneDrive\Dokument Peter OneDrive\Träning\Maps Garmin IMG\PHmaps") -Force
