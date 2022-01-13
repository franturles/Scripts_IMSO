#!/bin/bash

DOMINIO=iesallerflf

if [ -z "$DOMINIO" ];
	then
		echo "Introduce el nombre del dns sin el dominio de nivel superior \".local\""
		exit
else
	echo -e "[usuarios]\n\tpath=/Datos/usuarios\n\tread only = No\n" >> /etc/samba/smb.conf
	echo -e "[comun]\n\tpath=/Datos/comun\n\tread only = No\n" >> /etc/samba/smb.conf

	sed -i "/\[netlogon\]/i\\\thide unreadable = yes\n" /etc/samba/smb.conf

	#Creamos el script de inicio de windows

	echo -e '@echo off' > /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e 'REM Miramos se o usuario que inicia sesion es profesor' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e 'REM Si es de profesor mapeamos alumnos a S:' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e "   net user /domain %username% | findstr /C:\"g-alum\" && (" >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e '   net use S: \\\\dserver\\usuarios\\persoais\\alumnos /persistent:no' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e '   )' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat

	echo -e 'REM Ficheiro de inicio de sesion' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e 'REM Mapeamos comun para todo usuario que inicie sesion' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e 'net use R: \\\\dserver\\comun /persistent:no' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat

	echo -e 'REM Miramos se o usuario que inicia sesion es profesor' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e 'REM Si es de profesor mapeamos alumnos a S:' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e "   net user /domain %username% | findstr /C:\"g-alum\" && (" >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e '   net use S: \\\\dserver\\usuarios\\persoais\\alumnos /persistent:no' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo -e '   start \\dserver\netlogon\avisos\aviso\aviso_alumnos.html'
	echo -e '   )' >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat
	echo >> /var/lib/samba/sysvol/$DOMINIO.local/scripts/inicio.bat

	#Agregamos los permisos a la carpeta de scripts para que puedan acceder todos los usuarios

	setfacl -Rm g:g-usuarios:rx /var/lib/samba/sysvol/$DOMINIO.local/scripts/
	setfacl -Rdm g:g-usuarios:rx /var/lib/samba/sysvol/$DOMINIO.local/scripts/

	smbcontrol all reload-config
fi

