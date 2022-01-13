@echo off
setlocal enabledelayedexpansion
cls
:Menu
echo Selecciona por donde empezar: 
echo 1. Usuarios
echo 2. Carpetas
echo 3. Compartir
echo 4. Cuotas
echo E para Salir
choice /c:12E34
if errorlevel 5 goto Cuotas
if errorlevel 4 goto Compartir 
if errorlevel 3 goto Exit
if errorlevel 2 goto Carpetas
if errorlevel 1 goto Usuarios
:Usuarios
net user wadmin "abc123." /add
net user wservidor "abc123." /add
net user wuser01 "abc123." /add
net user wuser02 "abc123." /add 
net user wremoto "abc123." /add
net localgroup Administradores "wadmin" /add
echo La Creaccion de Usuarios salio de forma satisfactoria
pause
goto Menu
:Carpetas
cls
echo Vamos a Crear las carpetas
md c:\compWuser02
md c:\compWuser01
md c:\compServidor
md c:\compAsistencia
mkdir c:\compAsistencia
net share compAsistencia$=c:\compAsistencia /grant:wremoto,full
icacls c:\compServidor /grant wservidor:RW
icacls c:\compWuser01 /grant wuser01:M
icacls c:\compWuser02 /grant wuser02:M
pause
goto Menu
:Compartir
net share compServidor=c:\compServidor /grant:wservidor,full
net share compWuser01=c:\compWuser01 /grant:wuser01,change
net share compWuser02=C:\compWuser02 /grant:wuser02,change
net share compAsistencia$=C:\compAsistencia /grant:wremoto,full

pause
goto Menu
:Cuotas
fsutil quota track C:
fsutil quota modify C: 13421772800 26843545600 wadmin
fsutil quota modify C:\ 5368709120 10737418240 wuser01
fsutil quota modify C:\ 5368709120 10737418240 wuser02
fsutil quota modify C:\ 536870912 1073741824 wservidor
fsutil quota modify C:\ 536870912 1073741824 wremoto
pause
goto Menu
:Exit
