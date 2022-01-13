#net share datos=$Unidad\Usuarios\Datos /grant:Todos,full
#net share perfiles$=$Unidad\Usuarios\Perfiles /grant:Todos,full
#net share redireccionamiento=$Unidad\Usuarios\Redireccionamintos /grant:Todos,full
#net share software$=$Unidad\Usuarios\Software /grant:Todos,full

.\00-variables.ps1
New-SMBShare -Name "perfiles$" -Path  $Unidad\Usuarios\Perfiles -FullAccess Todos | out-null
New-SMBShare -Name "software$" -Path  $Unidad\Usuarios\Software -FullAccess Todos | out-null
New-SMBShare -Name "datos" -Path  $Unidad\Usuarios\Datos -FullAccess Todos | out-null
New-SMBShare -Name "redireccionamiento" -Path  $Unidad\Usuarios\Redireccionamintos -FullAccess Todos | out-null
