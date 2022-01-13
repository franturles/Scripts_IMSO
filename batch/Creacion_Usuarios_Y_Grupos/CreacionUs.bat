@echo off
chcp 65001 >null
setlocal enabledelayedexpansion
if "%1" == "/?" (
	echo Saltando ayuda...
	type Ayuda.txt
)
::for /f eol=(linea de comentario) delims=(delimitador de campos) tokens(campos que vamos a utilizar) %%i (variable del bucle)
:I
echo Seleccione una de estas opciones:
echo C = Crear usuarios
echo B = Borrar usuarios
echo M = Muestre Usuarios y Grupos
echo E = Salir del Menu
choice /c:CBEM /m "Selecione" 
IF ERRORLEVEL 4 GOTO M
IF ERRORLEVEL 3 GOTO E
IF ERRORLEVEL 2 GOTO B
IF ERRORLEVEL 1 GOTO C


:C
net localgroup g-manana /add
net localgroup g-tarde /add
net localgroup g-direccion /add
for /f "eol=# delims=; tokens=1-5" %%l in (Usuario.txt) do (
		set nombre=%%n
		set apellido1=%%m
		set apellido2=%%l
		set Cargo=%%o
		set Turno=%%p
		set login= !nombre!!apellido1:~0,1!!apellido2:~0,1!
		rem	echo !login!
		if "!Cargo!" == "Administrativo" (
			if "!Turno!" == "7:00 a 15:00" (
				net user !login! /random /add /times:l-v,7am-3pm /fullname:"%%n %%m %%l" >> pass.tmp
				net localgroup g-manana !login! /add 
			) else (
				net user !login! /random /add /times:l-v,3am-11pm /fullname:"%%n %%m %%l" >> pass.tmp
				net localgroup g-tarde !login! /add
			)
		) else (
			net user !login! /random /add /times:l-v,7am-11pm /fullname:"%%n %%m %%l" >> pass.tmp
			net localgroup g-direccion !login! /add
		)
)
findstr /R "^La Contrase" pass.tmp > pass.txt
del pass.tmp
goto E 

:B
for /f "eol=# delims=; tokens=1-5" %%l in (Usuario.txt) do (
		set nombre=%%n
		set apellido1=%%m
		set apellido2=%%l
		set Cargo=%%o
		set Turno=%%p
		set login= !nombre!!apellido1:~0,1!!apellido2:~0,1!
		net user !login! /delete
		net localgroup g-manana /delete
		net localgroup g-tarde /delete
)

goto E 
:M
echo Seleccione un Grupo:
echo 1.g-manana
echo 2.g-tarde
echo 3.g-direccion
echo 4.Salir
choice /c:1234
IF ERRORLEVEL 4 GOTO Salir
IF ERRORLEVEL 3 GOTO G3
IF ERRORLEVEL 2 GOTO G2
IF ERRORLEVEL 1 GOTO G1
	:G1
	cls
	Echo Mostrando..
	net localgroup g-manana
	goto M
	:G2
	cls
	Echo Mostrando..
	net localgroup g-tarde
	goto M
	:G3
	cls
	Echo Mostrando..
	net localgroup g-direccion
	goto M
	:Salir
	goto I

:E 
echo fin 
