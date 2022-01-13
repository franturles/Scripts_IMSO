#!/bin/bash

DOMINIO="$1"
DOMINIOMA=`echo "$DOMINIO" | tr [[:lower:]] [[:upper:]]`
EQUIPO=uclient01

if [ -z "$DOMINIO" ];
	then
		echo "Introduce el nombre del dns sin el dominio de nivel superior \".local\""
		exit

	else
		#Agregamos las lineas a pam_mount.conf.xml para que monte de forma automatica carpetas remotas segun el usuario
		#La carpeta personal
		sed -i "/<\/pam_mount>/i\\\n<logout wait=\"0\" hup=\"0\" term=\"0\" kill=\"0\" \/>\n\n\t\t<\!-- pam_mount parameters: Volume-related -->\n\n<mkmountpoint enable=\"1\" remove=\"true\" />\n\n<volume sgrp=\"g-direccion\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/personal/oficina/directores/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\)\" />\n<volume sgrp=\"g-rrhh\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/personal/oficina/rrhh/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\),gid=g-direccion\" />\n<volume sgrp=\"g-ingenieros\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/personal/ingenieros/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\)\" />\n<volume sgrp=\"g-electricistas\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/personal/electricistas/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\)\" />" /etc/security/pam_mount.conf.xml
		sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-profes\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/profes/%(USER)\" mountpoint=\"/media/%(USER)/Persoal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER)\" />" /etc/security/pam_mount.conf.xml
		sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-dam1-alum\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/alumnos/dam1/%(USER)\" mountpoint=\"/media/%(USER)/Persoal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER),gid=g-dam1-profes\" />" /etc/security/pam_mount.conf.xml
		sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-dam2-alum\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/alumnos/dam2/%(USER)\" mountpoint=\"/media/%(USER)/Persoal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER),gid=g-dam2-profes\" />" /etc/security/pam_mount.conf.xml
		sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-usuarios\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"comun\" mountpoint=\"/media/%(USER)/Comun\" options=\"workgroup=$DOMINIO,iocharset=utf8\" />" /etc/security/pam_mount.conf.xml
		sed -i "/<\/pam_mount>/i\\\n\<volume sgrp=\"g-profes\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/alumnos\" mountpoint=\"/media/%(USER)/Alumnos\" options=\"workgroup=$DOMINIO,iocharset=utf8\" />" /etc/security/pam_mount.conf.xml
		sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-usuarios\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/perfisLinux\" mountpoint=\"/home/local/$DOMINIOA\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER)\" />" /etc/security/pam_mount.conf.xml
fi
