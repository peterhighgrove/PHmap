$mapCreateConfig = Import-Csv -Path 'C:\Users\peter\Documents\Maps Garmin\PHmap\scripts\mapConfig.csv'
ForEach ($row in $mapCreateConfig) {
    if ($row.doPreStep -eq 'stopHere') {Write-Host 'STOP'; break}
    Write-Host $row
    if ($row.doPreStep.Substring(0,1) -eq '#') {continue}
    Write-Host ('C:\Users\peter\Documents\Maps Garmin\OSMsplitted\' + $row.area)
    Write-Host '------------------------------'
}
