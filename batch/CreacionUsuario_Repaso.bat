@echo off
setlocal EnableDelayedExpansion
cls
echo BIENVENIDO A ESTA SCRIPT %username% Y VUESTRO EQUIPO SE LLAMA %computername%
pause
cls
if "%1"=="/?" (
	echo Desplegando ayuda
	type Ayuda.txt) 
echo --------------------------------
echo      "CUANTOS USUARIOS CREAR"
echo --------------------------------
echo 1.Un solo Usuario
echo 2.5 Usuarios 
echo 3.10 Usuarios
echo 4.Salir
choice /C:1234
if errorlevel == 4 goto Salir
if errorlevel == 3 goto 10_Usuarios
if errorlevel == 2 goto 5_Usuario
if errorlevel == 1 goto 1_Usuario

:10_Usuarios
		echo --------------------------------
		echo      "QUE QUIERES HACER"
		echo --------------------------------
		echo 1.Crear Usuario
		echo 2.Borrar Usuario
		echo 3.Salir
		choice /C:123
		if errorlevel == 3 goto Salir
		if errorlevel == 2 goto Borrar_Usuario_10
		if errorlevel == 1 goto Crear_Usuario_10
		:Borrar_Usuario_10
		for /L %%i in (1,1,10) do (
		cls
		net user
		set /p Usuario= "Introduce un nombre de usuario para Borrar "
		net user !Usuario! /delete 
		goto Salir
		)
		:Crear_Usuario_10
		for /L %%i in (1,1,10) do (
		cls
		set /p Usuario= "Crea un nombre de usuario "
		net user !Usuario! abc123. /add
		echo ---------------------------------
		echo 	"QUE PERMISOS QUIERES CREAR"
		echo ---------------------------------
		echo 1. Permisos normales
		echo 2. Permisos de Administrador 
		echo 3. Salir
		choice /C:123
		if errorlevel == 3 goto Salir
		if errorlevel == 2 goto Permisos_Administrador_10
		if errorlevel == 1 goto Permisos_Normales_10
			:Permisos_Normales_10
			net localgroup g-prueba !Usuario! /add
			goto Listo1
			
			:Permisos_Administrador_10
			net localgroup Administradores !Usuario! /add	
			echo 
			:Listo1
			echo
		)
		goto Salir


:5_Usuario
		echo --------------------------------
		echo      "QUE QUIERES HACER"
		echo --------------------------------
		echo 1.Crear Usuario
		echo 2.Borrar Usuario
		echo 3.Salir
		choice /C:123
		if errorlevel == 3 goto Salir
		if errorlevel == 2 goto Borrar_Usuario_5
		if errorlevel == 1 goto Crear_Usuario_5
		:Borrar_Usuario_5
		for /L %%i in (1,1,5) do (
		cls
		net user
		set /p Usuario= "Introduce un nombre de usuario para Borrar "
		net user !Usuario! /delete 
		)
		:Crear_Usuario_5
		for /L %%i in (1,1,5) do (
		cls
		set /p Usuario= "Crea un nombre de usuario "
		net user !Usuario! abc123. /add
		echo ---------------------------------
		echo 	"QUE PERMISOS QUIERES CREAR"
		echo ---------------------------------
		echo 1. Permisos normales
		echo 2. Permisos de Administrador 
		echo 3. Salir
		choice /C:123
		if errorlevel == 3 goto Salir
		if errorlevel == 2 goto Permisos_Administrador_5
		if errorlevel == 1 goto Permisos_Normales_5
			:Permisos_Normales_5
			net localgroup g-prueba !Usuario! /add
			goto Listo2

			:Permisos_Administrador_5
			net localgroup Administradores !Usuario! /add
			:Listo2
			echo.
		)



:1_Usuario
		:Menu
		cls
		echo --------------------------------
		echo      "QUE QUIERES HACER"
		echo --------------------------------
		echo 1.Crear Usuario
		echo 2.Borrar Usuario
		echo 3.Salir
		choice /C:123
		if errorlevel == 3 goto Salir
		if errorlevel == 2 goto Borrar_Usuario_1
		if errorlevel == 1 goto Crear_Usuario_1
		:Borrar_Usuario_1
		cls
		set /p Usuario= "Introduce un nombre de usuario para Borrar "
		net user
		net user %Usuario% /delete
		goto Menu 

		:Crear_Usuario_1 
		cls
		set /p Usuario= "Crea un nombre de usuario "
		net user %Usuario% abc123. /add
		echo ---------------------------------
		echo 	"QUE PERMISOS QUIERES CREAR"
		echo ---------------------------------
		echo 1. Permisos normales
		echo 2. Permisos de Administrador 
		echo 3. Salir
		choice /C:123
		if errorlevel == 3 goto Salir
		if errorlevel == 2 goto Permisos_Administrador_1
		if errorlevel == 1 goto Permisos_Normales_1

			:Permisos_Normales_1
			net localgroup Usuarios %Usuario% /add
			goto Salir

			:Permisos_Administrador_1
			net localgroup Administradores %Usuario% /add

:Salir
