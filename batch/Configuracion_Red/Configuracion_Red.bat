@echo on
chcp 65001 >null
setlocal enabledelayedexpansion
:: Configuracion de la red
set equipo=%computername%
echo Empezamos...
echo Elige una de estas opciones:
echo 1.Dinamica
echo 2.Estatica
echo 3.Archivo
echo 4.Salir
choice /C:1234 /m "indica una Opcion"
if errorlevel 4 goto Fin
if errorlevel 3 goto Archivo
if errorlevel 2 goto Estatica
if errorlevel 1 goto Dinamica

:Archivo
for /f "eol=# delims=: tokens=1-6" %%i in (usuarios.txt) do (
	   set interface=%%j
	   set ip=%%k
	   set mask=%%l
	   set gw=%%m 
	   set dns1=%%n
	netsh interface ipv4 set address name="!nterface!" source="static" addr="!ip!" mask="!mask!" gateway=!gw!
	netsh interface ipv4 set dns name="!interface!" "!dns1!" primary
	netsh interface ipv4 add dnsservers !interface! "1.1.1.1" index=2
)
	goto Fin


:Dinamica
set /p interface="Escriba aqui la interfaz que usara"
netsh int ip set address name="%interface%" source = dhcp
goto Fin
)
:Estatica
set /p interface="Escriba la interfaz en la que va a configurar la red: "
set /p ip="Escriba aqui IP que usara: "
set /p mask="Escriba aqui mascara que usara:"
set /p gw="Escriba aqui gateway que usara: "
set /p dns1="Escriba aqui el DNS que usara: "
	netsh interface ipv4 set address name="%interface%" source=static addr=%ip% mask=%mask% gateway=%gw%
	netsh interface ipv4 set dnsservers "%interface%" "%dns1%" primary 
)

:Fin