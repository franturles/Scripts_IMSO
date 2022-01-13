@echo off
rem Modicamos la tabla a UTF-8
chcp 65001 > null
if "%1" == "/?" type Ayuda.txt && echo. && goto Salir
	:Menu
		echo 1. Notepad
		echo 2. Dia
		echo 3. LibreOffice
		echo 4. 7zip
		echo 5. Ayuda
		echo 6. Salir
		choice /C:123456 /m "Selecciona una opción..."
		if errorlevel == 6 goto Salir
		if errorlevel == 5 goto Ayuda
		if errorlevel == 4 goto 7zip
		if errorlevel == 3 goto LibreOffice
		if errorlevel == 2 goto Dia
		if errorlevel == 1 goto Notepad
		:Notepad
		choice /C:12 /m "Para instalar Notepad++ pulsa 1 y para desinstalar Notepad++ pulse 2"
			if errorlevel == 2 goto Desinstalar_Notepad
			if errorlevel == 1 goto Instalar_Notepad
			:Instalar_Notepad 
			START C:\Users\%username%\Downloads\Notepad rem Elegir la ruta donde tenemos el archivo .exe que queremos instalar
			echo Instalando Notepad...
			goto Menu
			:Desinstalar_Notepad
			START C:\Users\%username%\Desktop\Programas\uninstall rem Copiar archico uninstall fuera de la unidad C:\
			echo Desinstalando Notepad...
			goto Menu
		:Dia
		choice /C:12 /m "Para instalar Dia pulsa 1 y para desinstalar Dia pulse 2"
			if errorlevel == 2 goto Desinstalar_Dia
			if errorlevel == 1 goto Instalar_Dia
			:Instalar_Dia
			START C:\Users\%username%\Downloads\Dia rem Elegir la ruta donde tenemos el archivo .exe que queremos instalar
			echo Instalando Dia...
			goto Menu
			:Desinstalar_Dia
			START C:\Users\%username%\Desktop\Programas\dia-0.97.2-uninstall rem Copiar archico uninstall fuera de la unidad C:\
			echo Desinstalando Dia...
			goto Menu
		:LibreOffice
		choice /C:12 /m "Para instalar LibreOffice pulsa 1 y para desinstalar LibreOffice pulse 2"
			if errorlevel == 2 goto Desinstalar_LibreOffice
			if errorlevel == 1 goto Instalar_LibreOffice
			:Instalar_LibreOffice
			START C:\Users\%username%\Downloads\LibreOffice_7.0.3_Win_x64 rem Elegir la ruta donde tenemos el archivo .exe que queremos instalar
			echo Instalando LibreOffice...
			goto Menu
			:Desinstalar_LibreOffice
			START C:\Users\%username%\Desktop\Programas\uninstall rem Copiar archico uninstall fuera de la unidad C:\
			echo Desinstalando LibreOffice...
			goto Menu
		:7zip
		choice /C:12 /m "Para instalar 7zip pulsa 1 y para desinstalar 7zip pulsa 2"
			if errorlevel == 2 goto Desinstalar_7zip
			if errorlevel == 1 goto Instalar_7zip
			:Instalar_7zip
			START C:\Users\%username%\Downloads\7z1900-x64 rem Elegir la ruta donde tenemos el archivo .exe que queremos instalar
			echo Instalando 7-Zip...
			goto Menu
			:Desinstalar_7zip
			START C:\Users\%username%\Desktop\Programas\Uninstall_7zip rem Copiar archico uninstall fuera de la unidad C:\
			echo Desinstalando 7-Zip...
			goto Menu
		:Ayuda
		type Ayuda.txt
		echo.
		goto Menu
		:Salir
		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			