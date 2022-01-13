@echo off
rem Modificamos la tabla de codigo a utf-8
chcp 65001 > nul
if "%1"=="" (
	echo "Error: Necesito parametro"
	type Ayuda.txt
) else (
	echo "Parametro pasado a ver que hacemos..." 
rem Aqui indicamos que si el primer parametro es /? entonces mostrara el documento Ayuda.txt
	if "%1"=="/?" (
		type Ayuda.txt
	) else (
		echo "opcion A-Copia Completa"
		echo "opcion B-Copia Incremental"
		echo "opcion C-Copia Diferencial"
		echo "opcion D-Salir del menu"
		choice /C:abcd /m "indica una Opcion"
		if errorlevel == 4 goto Salir
		if errorlevel == 3 goto CopiaDiferencial
		if errorlevel == 2 goto CopiaIncremental
		if errorlevel == 1 goto CopiaCompleta
		:CopiaCompleta
			echo haciendo copia completa...
			set Fecha=%date:~0,2%-%date:~3,2%-%date:~6,2%
			rem %date:~0,2%-%date:~3,2%-%date:~6,2%
			set Nombre=%2%fecha%
			echo %nombre% 
			xcopy /e /h /y /q /s /i %1 %nombre%
			echo Saliendo...
			goto Salir
			
		:CopiaIncremental
			echo haciendo copia incremental...
			set Fecha=%date:~0,2%-%date:~3,2%-%date:~6,2%
			set Nombre=%2%fecha%
			echo %nombre% 
			xcopy /m /h /y /q /s /i %1 %nombre%
			echo Saliendo...
			goto Salir
		:CopiaDiferencial
			echo haciendo copia Diferencial...
			set Fecha=%date:~0,2%-%date:~3,2%-%date:~6,2%
			set Nombre=%2%fecha%
			echo %nombre% 
			xcopy /e /h /y /d /s /i %1 %nombre%
			echo Saliendo...
			goto Salir
		:Salir
			echo FIN
	)
)