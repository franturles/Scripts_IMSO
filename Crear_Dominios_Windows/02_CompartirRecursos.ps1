.\00-variables.ps1
#net share datos=$Unidad\Usuarios\Datos /grant:Todos,full
#net share perfiles$=$Unidad\Usuarios\Perfiles /grant:Todos,full
#net share redireccionamiento=$Unidad\Usuarios\Redireccionamintos /grant:Todos,full
#net share software$=$Unidad\Usuarios\Software /grant:Todos,full

New-SMBShare -Name "perfiles$" -Path  $env:Unidad\Usuarios\Perfiles -FullAccess Todos | out-null
New-SMBShare -Name "software$" -Path  $env:Unidad\Usuarios\Software -FullAccess Todos | out-null
New-SMBShare -Name "datos" -Path  $env:Unidad\Usuarios\Datos -FullAccess Todos | out-null
New-SMBShare -Name "redireccionamiento" -Path  $env:Unidad\Usuarios\Redireccionamintos -FullAccess Todos | out-null