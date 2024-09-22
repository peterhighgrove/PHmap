
$hgtFolder = "C:\Users\peter\Documents\Maps Garmin\hgt\SONN"    # Downloaded hgt files
  if (! (Test-Path -Path $hgtFolder)) {Write-Output ('NO SUCH FOLDER @ ' + $hgtFolder); Exit}
  $area = 'sfdsf'
$hgtFilter = $hgtFolder + '\' + $area + "\" + "*.hgt"
if (! (Test-Path $hgtFilter)) { Write-Output ('NO HGT FILES @ ' + $hgtFilter); Exit }
else {Write-Host 'YES'}
