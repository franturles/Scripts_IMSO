@echo off
REM MODICAMOS LA TABLA A UTF-8
chcp 65001 > null
setlocal enabledelayedexpansion

if "%1" == "" (
	goto menu
) else (
	goto file_conf
)

	:menu
	cls
	:nocls_main
	echo 1. Configuración dinámica
	echo 2. Configuración estática
	echo 3. Salir

	choice /C:123 /m "Selecciona una opción..."
	if errorlevel == 3 goto exit
	if errorlevel == 2 goto static_conf
	if errorlevel == 1 goto dynamic_conf

		:dynamic_conf
		REM RECIBIMOS IP Y DNS POR DHCP
		netsh interface ip set address "Ethernet" dhcp
		netsh interface ip set dns "Ethernet" dhcp
		goto menu
		
		:static_conf
		REM CONFIGURAMOS LA RED DE FORMA ESTÁTICA
		set /p interface="Nombre de la interfaz: "
		set /p ip="IP del equipo: "
		set /p mask="Máscara de red (En decimal): "
		set /p gw="IP de la puerta de enlace (Router): "
		set /p dns1="IP del servidor DNS principal: "
		set /p dns2="IP del servidor DNS secundario: "
		netsh interface ipv4 set address name="%interface%" source="static" addr=%ip% mask=%mask% gateway=%gw%
		netsh interface ipv4 set dnsservers "%interface%" "static" "%dns1%" primary > NUL
		netsh interface ipv4 add dnsservers "%interface%" "%dns2%" index=2 > NUL
		goto menu

		REM CONFIGURACIÓN DE RED DESDE ARCHIVO
		:file_conf
		REM CREAMOS VARIABLE DE NOMBRE DE EQUIPO Y GUARDAMOS EN CONF.TMP
		set equipo=%computername%
		findstr /I /R "^%equipo%:" %1 > conf.tmp
		REM RECORREMOS EL FICHERO BUSCANDO LA LÍNEA CON EL NOMBRE DE NUESTRO EQUIPO
		for /f "eol=# delims=: tokens=1-6" %%i in (conf.tmp) do (
			set interface=%%j
			set ip=%%k
			set mask=%%l
			set gw=%%m
			set dns=%%n
			netsh interface ipv4 set address name="%%j" source="static" addr=%%k mask=%%l gateway=%%m
			netsh interface ipv4 set dnsservers "%%j" "static" "%%n" primary > NUL
			netsh interface ipv4 add dnsservers "%%j" "8.8.4.4" index=2 > NUL
		)
		del conf.tmp
		
		:exit
		cls