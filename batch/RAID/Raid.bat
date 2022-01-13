@echo off
cls
if exist DiskPrueba.txt (
del DiskPrueba.txt 
)
echo Seleccione una de estas opciones:
echo A = Crear Raid 0
echo B = Crear Raid 1
echo C = Salir
choice /c:ABC 
if errorlevel 3 goto Salir
if errorlevel 2 goto Crear_RAID1
if errorlevel 1 goto Crear_RAID0

:Crear_RAID0 
cls
echo --------------------------------------
echo Bienvenido al Menu para crear el Raid1
echo --------------------------------------
echo list disk >> DiskPrueba.txt
diskpart /s DiskPrueba.txt
if exist DiskPrueba.txt (
del DiskPrueba.txt 
)
set /p RAID01= "Selecciona un Disco: "
set /p RAID02= "Selecciona un Disco: "
echo select disk %RAID01% >> DiskPrueba.txt
echo convert dynamic >> DiskPrueba.txt
echo select disk %RAID02% >> DiskPrueba.txt
echo convert dynamic >> DiskPrueba.txt
echo select volume 1 >> DiskPrueba.txt
echo create volume stripe size=2048 disk="%RAID01%,%RAID02%" >> DiskPrueba.txt
echo list volume >> DiskPrueba.txt
echo select volume 3 >> DiskPrueba.txt
echo format fs=ntfs label="Seccionado" quick >> DiskPrueba.txt
echo assign letter S: >> DiskPrueba.txt
diskpart /s DiskPrueba.txt
if exist DiskPrueba.txt (
del DiskPrueba.txt 
)
goto Salir
pause
cls

:Crear_RAID1

echo --------------------------------------
echo Bienvenido al Menu para crear el Raid0
echo --------------------------------------
echo list disk >> DiskPrueba.txt
diskpart /s DiskPrueba.txt
if exist DiskPrueba.txt (
del DiskPrueba.txt 
)
set /P RAID11= "Selecciona un Disco: "
set /P RAID12= "Selecciona un Disco: "
echo select disk %RAID11% >> DiskPrueba.txt
echo convert dynamic >> DiskPrueba.txt
echo select disk %RAID12% >> DiskPrueba.txt
echo convert dynamic >> DiskPrueba.txt
echo select volume 2 >> DiskPrueba.txt
echo create volume mirror disk="%RAID01%,%RAID02%" >> DiskPrueba.txt
echo list volume >> DiskPrueba.txt
echo select volume 3 >> DiskPrueba.txt
echo format fs=ntfs label="Reflejo" quick >> DiskPrueba.txt
echo assign letter=R >> DiskPrueba.txt
diskpart /s DiskPrueba.txt
if exist DiskPrueba.txt (
del DiskPrueba.txt 
)
goto Salir


:Salir
echo Saliendo...
