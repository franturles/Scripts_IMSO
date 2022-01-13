#!/bin/bash

DOMINIO="$1"
DOMINIOMA=`echo "$DOMINIO" | tr [[:lower:]] [[:upper:]]`
EQUIPO="$(hostname)"

if [ -z "$DOMINIO" ];
	then
		echo "Introduce el nombre del dns sin el dominio de nivel superior \".local\""
		exit

	else
		##Modificación de nsswitch.conf para que la resolución de nombres de domini se haga a traves de los ficheros locales y el dns
		sed -i '/^hosts/c\hosts:\t\tfiles dns' /etc/nsswitch.conf
		#echo $EQUIPO.$DOMINIO.local > /etc/hostname
		#sed -i 's/$EQUIPO/$EQUIPO $EQUIPO.$DOMINIO.local/' /etc/hosts
		#hostname $EQUIPO.$DOMINIO.local
		apt-get update && apt-get install libpam-mount cifs-utils ntp -y
		#Comentamos los servidores ntp por defecto
		sed -i "s/^server/#&/" /etc/ntp.conf
		#Agregamos los servidores que queremos
		sed -i "/^#server 3/a\server 1.es.pool.ntp.org\nserver 0.europe.pool.ntp.org\nserver 3.europe.pool.ntp.org" /etc/ntp.conf
		systemctl restart ntp.service
		#ntpq -p
		wget "https://github.com/BeyondTrust/pbis-open/releases/download/9.1.0/pbis-open-9.1.0.551.linux.x86_64.deb.sh"
		sh pbis-open-9.1.0.551.linux.x86_64.deb.sh
		#Reinstalamos ssh para evitar errores
		echo Resolvemos Errores...
		sudo apt-get remove openssh-client && apt update && sudo apt-get install openssh-server -y
		#Agregamos el equipo al dominio
		echo "Añadiendo $EQUIPO al dominio $DOMINIO"
		domainjoin-cli join "$DOMINIOMA".LOCAL Administrator
		/opt/pbis/bin/config AssumeDefaultDomain true
		/opt/pbis/bin/config UserDomainPrefix "$DOMINIOMA"
		/opt/pbis/bin/config HomeDirUmask 077
		/opt/pbis/bin/config LoginShellTemplate /bin/bash
		#Si es una distribución de ubuntu editamos el
		if [ `uname -a | cut -d" " -f6` = Ubuntu ]
			then
				#permitir dar un nombre de usuario para iniciar sesion #ocultamos el listado de usuarios 
				echo "greeter-show-manual-login=true\ngreeter-hide-users=true" >> /usr/share/lightdm/lightdm.conf.d/50-ubuntu.conf
		fi
		##la configuracion siguiente se corresponde con la carpet personal, perfiles etc.
		#Agregamos las lineas a pam_mount.conf.xml para que monte de forma automatica carpetas remotas segun el usuario
		#La carpeta personal
		#sed -i "/<\/pam_mount>/i\\\n<logout wait=\"0\" hup=\"0\" term=\"0\" kill=\"0\" \/>\n\n\t\t<\!-- pam_mount parameters: Volume-related -->\n\n<mkmountpoint enable=\"1\" remove=\"true\" />\n\n<volume sgrp=\"g-direccion\" fstype=\"cifs\" server=\"dserver.$DOMINIO.local\" path=\"usuarios/personal/oficina/directores/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\)\" />\n<volume sgrp=\"g-rrhh\" fstype=\"cifs\" server=\"dserver.$DOMINIO.local\" path=\"usuarios/personal/oficina/rrhh/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\),gid=g-direccion\" />\n<volume sgrp=\"g-ingenieros\" fstype=\"cifs\" server=\"dserver.$DOMINIO.local\" path=\"usuarios/personal/ingenieros/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\)\" />\n<volume sgrp=\"g-electricistas\" fstype=\"cifs\" server=\"dserver.$DOMINIO.local\" path=\"usuarios/personal/electricistas/%(USER)\" mountpoint=\"/media/\%\(USER\)/Personal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=\%\(USER\)\" />" /etc/security/pam_mount.conf.xml
		#sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-profes\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/profes/%(USER)\" mountpoint=\"/media/%(USER)/Persoal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER)\" />" /etc/security/pam_mount.conf.xml
		#sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-dam1-alum\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/alumnos/dam1/%(USER)\" mountpoint=\"/media/%(USER)/Persoal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER),gid=g-dam1-profes\" />" /etc/security/pam_mount.conf.xml
		#sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-dam2-alum\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/alumnos/dam2/%(USER)\" mountpoint=\"/media/%(USER)/Persoal\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER),gid=g-dam2-profes\" />" /etc/security/pam_mount.conf.xml
		#sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-usuarios\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"comun\" mountpoint=\"/media/%(USER)/Comun\" options=\"workgroup=$DOMINIO,iocharset=utf8\" />" /etc/security/pam_mount.conf.xml
		#sed -i "/<\/pam_mount>/i\\\n\<volume sgrp=\"g-profes\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/persoais/alumnos\" mountpoint=\"/media/%(USER)/Alumnos\" options=\"workgroup=$DOMINIO,iocharset=utf8\" />" /etc/security/pam_mount.conf.xml
		#sed -i "/<\/pam_mount>/i\\\n<volume sgrp=\"g-usuarios\" fstype=\"cifs\" server=\"dserver00.$DOMINIO.local\" path=\"usuarios/perfisLinux\" mountpoint=\"/home/local/$DOMINIOA\" options=\"workgroup=$DOMINIO,iocharset=utf8,uid=%(USER)\" />" /etc/security/pam_mount.conf.xml
fi
