<#
 Download osm datafiles
 Save to $srcFolder = "C:\Users\peter\Documents\Maps Garmin\OSMlatest\"
 File need to end with  '-latest.osm.pbf"'
 File start with $row.areaSrcFilePrefix
 $srcFile = '"' + $srcFolder + $row.areaSrcFilePrefix + '-latest.osm.pbf"'
 $row.area is the short descript
 $row.date for the files
 Choose a unique $row.pidd (SEcont above needs 5000-5052)
   Map pid SE=1000, FRlang=2000, FRalps=3000
 
 SE pid1000
 FRlang pid2000
 FRalps pid3000
#>
#$doPreStep = 0

<#
$row.areaSrcFilePrefix = "sweden"
$row.country = "Sweden"
$row.countryShort = "SE"
$row.area = "SEall"
$row.descSuffix = ""
$row.pidd = 1000
$row.date = 240907
#>
<#
$row.areaSrcFilePrefix = "languedoc-roussillon"
$row.country = "France"
$row.countryShort = "FR"
$row.area = "FRlang"
$row.descSuffix = ""
$row.pidd = 2000
$row.date = 240907
#>
<#
$row.areaSrcFilePrefix = "rhone-alpes"
$row.country = "France"
$row.countryShort = "FR"
$row.area = "bbFRalps"
$row.descSuffix = ""
$row.pidd = 3000
$row.date = 240805
#>
$srcFolder = "C:\Users\peter\Documents\Maps Garmin\OSMlatest\"      # Downloaded OSM map file
  if (! (Test-Path -Path $srcFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $srcFolder); Exit}
$hgtFolder = "C:\Users\peter\Documents\Maps Garmin\hgt\SONN"    # Downloaded hgt files
  if (! (Test-Path -Path $hgtFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $hgtFolder); Exit}
$osmSplittedFolder = "C:\Users\peter\Documents\Maps Garmin\OSMsplitted"     # Splitted files in Area subdir. Splitter do not allow to end with \
  if (! (Test-Path -Path $osmSplittedFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $osmSplittedFolder); Exit}
$styleFolder = "C:\Users\peter\Documents\Maps Garmin\PHmap\styles\all"    # MkGmap style
  if (! (Test-Path -Path $styleFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $styleFolder); Exit}
$GmapsFolder = "C:\Users\peter\Documents\Maps Garmin\OSM_Gmaps"    # MkGmap resulting .img. mkGmap do not allow to end with \
  if (! (Test-Path -Path $GmapsFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $GmapsFolder); Exit}
$typFile = "C:\Users\peter\Documents\Maps Garmin\PHmap\typ\phTyp25.typ"    # MkGmap typfile
  if (! (Test-Path $typFile)) {Write-Output ('NO SUCH FILE @ ' + $typFile); Exit}
$PHmapsFolder = "C:\Users\peter\Documents\Maps Garmin\PHmaps"    # Folder for created maps
  if (! (Test-Path -Path $PHmapsFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $PHmapsFolder); Exit}
$PHmaps1drvFolder = "C:\Users\peter\OneDrive\Dokument Peter OneDrive\Träning\Maps Garmin IMG\PHmaps"    # Folder for created maps
  if (! (Test-Path -Path $PHmaps1drvFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $PHmaps1drvFolder); Exit}

$mapCreateConfig = Import-Csv -Path 'C:\Users\peter\Documents\Maps Garmin\PHmap\scripts\mapConfig.csv'

ForEach ($row in $mapCreateConfig) {
  if ($row.type -eq 'stopHere') {
    Write-Output ($(Get-Date -format "HH:mm:ss") + ' FINISHED after tag "stopHere"')
    Write-Host '-----------------------------'
    break
  }
  if ($row.type.Substring(0,1) -eq '#') {
    Write-Output ($row.type)
    continue
  }
  
  Write-Output ($(Get-Date -format "HH:mm:ss") + ' STARTING NEW w config:' + $row)
  Write-Host '-----------------------------'

  $osmSplittedAreaFolder = $osmSplittedFolder + '\' + $row.area        #Splitter do not allow to end with \
  if (! (Test-Path -Path $osmSplittedAreaFolder)) {
      New-Item -ItemType Directory -Path $osmSplittedAreaFolder }

  # ------------------------------------------------------
  # SPLITTER
  # ------------------------------------------------------
  if ($row.doPreStep -eq 'spl') {

    del ($osmSplittedAreaFolder + '\*')
    #cd $osmSplittedAreaFolder  # Only needed for pyHgtMap

    $srcFile = $srcFolder + $row.areaSrcFilePrefix + '-latest.osm.pbf'
    if (! (Test-Path $srcFile)) {Write-Output ('NO LATEST OSM FILE @ ' + $srcFile); Exit}

    $javaArgs='-Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\Splitter\splitter.jar"'
    $splitterArgs = ''
    $splitterArgs = $splitterArgs + ' --output-dir="' + $osmSplittedAreaFolder + '"'
    $splitterArgs = $splitterArgs + ' --mapid=6328' + $row.pidd
    $splitterArgs = $splitterArgs + ' --description=' + $row.area + $row.descSuffix + '_' + $row.date + '_OSMtile'
    $splitterArgs = $splitterArgs + ' "' + $srcFile + '"'
    #$splitterArgs = $splitterArgs + ' > "' + $row.area + 'splitter.log"'
    Write-Host '-----------------------------'
    Write-Output $javaArgs
    Write-Output $splitterArgs
    Write-Host '-----------------------------'
    Write-Host ($(Get-Date -format "HH:mm:ss") + ' Starting splitter...')

    Start-Process -FilePath "C:\Program Files  z(x86)\Common Files\Oracle\Java\java8path\Java.exe" -ArgumentList $javaArgs, $splitterArgs -Wait -RedirectStandardOutput ('C:\Users\peter\Documents\logSpl' + $row.area + $row.descSuffix + '.log') -NoNewWindow
    Write-Host ($(Get-Date -format "HH:mm:ss") + ' Splitter ready.')
  }
  # ------------------------------------------------------
  # pyHgtMap w HGT files
  # ------------------------------------------------------
  if ($row.doPreStep -eq 'hgt') {

    del ($osmSplittedAreaFolder + '\*')
    cd $osmSplittedAreaFolder  # Only needed for pyHgtMap

    $pyHgtMapArgs = ''
    $pyHgtMapArgs = $pyHgtMapArgs + ' --step=' + $row.contourStep
    $pyHgtMapArgs = $pyHgtMapArgs + ' --line-cat=' + $row.contourMajor + ',' + $row.contourMinor 
    $pyHgtMapArgs = $pyHgtMapArgs + ' --no-zero-contour'
    $pyHgtMapArgs = $pyHgtMapArgs + ' --pbf'

    $hgtFilter = $hgtFolder + '\' + $row.area + "\" + "*.hgt"
    if (! (Test-Path $hgtFilter)) { Write-Output ('NO HGT FILES @ ' + $hgtFilter); Exit }

    $hgtFiles = ( Get-ChildItem -Path $hgtFilter ).FullName -join '" "'
    $hgtFiles = '"' + $hgtFiles + '"'
    Write-Host '-----------------------------'
    Write-Output $pyHgtMapArgs
    Write-Output $hgtFiles
    Write-Host '-----------------------------'

    Write-Host ($(Get-Date -format "HH:mm:ss") + ' Starting pyHgtMap...')
    Start-Process -FilePath "C:\Users\peter\AppData\Local\Programs\Python\Python311\Scripts\pyHgtMap.exe" -ArgumentList $pyHgtMapArgs, $hgtFiles -Wait -RedirectStandardOutput ('C:\Users\peter\Documents\logPyHgt' + $row.area + $row.descSuffix + '.log') -NoNewWindow
    Write-Host ($(Get-Date -format "HH:mm:ss") + ' pyHgtMap ready')

    # ------------------------------------------------------
    # Template file creating
    # ------------------------------------------------------

    $templateFile = $osmSplittedAreaFolder + "\template.args"
    $osmFilter = $osmSplittedAreaFolder + "\*.osm.pbf"
    $i = [int]$row.pidd

    dir $osmFilter | ForEach {
      $i = $i + 1
      $variable = "mapname: 6328" + $i + "`n" + "description: " + $row.area + "_" + $row.descSuffix + "_OSMtile" + "`n" + "input-file: $($_.Name)`n"
      #Write-Output $variable
      Add-Content -Value $variable -Path $templateFile
    }
  }

  # ------------------------------------------------------
  # MKGMAP
  # ------------------------------------------------------
  
  $templateFile = $osmSplittedAreaFolder + "\template.args"
  if (! (Test-Path $templateFile)) { Write-Output ('NO SPLITTED DATA @ ' + $templateFile); Exit }

  del ($GmapsFolder + '\*')

  if ($row.type -eq 'map') {
    $mapDescription = $row.area + '_PHmap' + $row.descSuffix + '_' + $row.date + '_' + $row.pidd
    if ($row.drawPrio -eq '')  {$drawPrio = 20} else {$drawPrio = $row.drawPrio}
  }
  else {
    $mapDescription = $row.area + '_PHmap' + $row.descSuffix + '_' + $row.contourStep + '-' + $row.contourMinor + '-' + $row.contourMajor + '_' + $row.pidd
    if ($row.drawPrio -eq '')  {$drawPrio = 80} else {$drawPrio = $row.drawPrio}
  }
  
  $javaArgs='-Xmx8G -jar "C:\Users\peter\Documents\Maps Garmin\MKGmap\mkgmap.jar"'
  $mkGmapsArgs = ''
  if ($row.type -eq 'cont') {$mkGmapsArgs = $mkGmapsArgs + ' --transparent'}
  $mkGmapsArgs = $mkGmapsArgs + ' --generate-sea=multipolygon'
  $mkGmapsArgs = $mkGmapsArgs + ' --add-pois-to-areas'
  $mkGmapsArgs = $mkGmapsArgs + ' --country-name=' + $row.country
  $mkGmapsArgs = $mkGmapsArgs + ' --country-abbr=' + $row.countryShort
  $mkGmapsArgs = $mkGmapsArgs + ' --family-id=4000'
  $mkGmapsArgs = $mkGmapsArgs + ' --family-name=PHmap'
  $mkGmapsArgs = $mkGmapsArgs + ' --product-id=' + $row.pidd
  $mkGmapsArgs = $mkGmapsArgs + ' --draw-priority=' + $drawPrio
  $mkGmapsArgs = $mkGmapsArgs + ' --code-page=1252'
  $mkGmapsArgs = $mkGmapsArgs + ' --style-file="' + $styleFolder + '"'
  $mkGmapsArgs = $mkGmapsArgs + ' --output-dir="' + $GmapsFolder + '"'
  $mkGmapsArgs = $mkGmapsArgs + ' --gmapsupp'
  $mkGmapsArgs = $mkGmapsArgs + ' -c "' + $templateFile + '"'
  $mkGmapsArgs = $mkGmapsArgs + ' "' + $typFile + '"'
  $mkGmapsArgs = $mkGmapsArgs + ' --description=' + $mapDescription # need to be at the end to get the descr in file

  Write-Host '-----------------------------'
  Write-Output $javaArgs
  Write-Output $mkGmapsArgs
  Write-Host '-----------------------------'

  Write-Host ($(Get-Date -format "HH:mm:ss") + ' Starting mkGmap...')
  Start-Process -FilePath "C:\Program Files (x86)\Common Files\Oracle\Java\java8path\Java.exe" -ArgumentList $javaArgs, $mkGmapsArgs -Wait -NoNewWindow
  Write-Host ($(Get-Date -format "HH:mm:ss") + ' mkGmap ready.')

  $newFileName = $mapDescription + '.img'
  Write-Host '-----------------------------'
  Write-Host ($(Get-Date -format "HH:mm:ss") + ' Moving/copying file as: ' + $newFileName)
  Write-Host '-----------------------------'
  Move-Item -Path ($GmapsFolder + '\gmapsupp.img') -Destination ($PHmapsFolder + '\' + $newFileName) -Force
  Copy-Item -Path ($PHmapsFolder + '\' + $newFileName) -Destination ($PHmaps1drvFolder) -Force
}