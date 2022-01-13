#!/bin/bash
#CREAR ALUMNOS
for i in `cat $1`; do
	# Extraemos os campos dos usuarios
        LOGIN=`echo $i | cut -f 1 -d :`
        NOME=`echo $i | cut -f 2 -d :`
        APELIDOS=`echo $i | cut -f 3 -d :`
        GRUPO=`echo $i | cut -f 4 -d :`
        USERID=`echo $i | cut -f 5 -d :`

        # Engadimos o usuario con samba-tool e introducimolo nos grupos que lle corresponda
        echo -n "Engadindo usuario $LOGIN..."
        samba-tool user create $LOGIN abc123. --given-name=$NOME --surname=$APELIDOS --userou=OU=$GRUPO,OU=alumnos,OU=usuarios --uid-number=$USERID --home-drive=Z: --home-directory=\\\\dserver00\\usuarios\\persoais\\alumnos\\$GRUPO\\$LOGIN --profile-path=\\\\dserver\\usuarios\\perfilWindows\\$LOGIN --script-path=inicio.bat
        samba-tool group addmembers g-usuarios $LOGIN
        samba-tool group addmembers g-alum $LOGIN
        samba-tool group addmembers g-$GRUPO-alum $LOGIN
        echo "[OK]"
done

#CREAR PROFESORES
samba-tool user create sol abc123. --given-name=Sol --surname=Lua --userou=OU=profes,OU=usuarios --uid-number=10000 --home-drive=Z: --home-directory=\\\\dserver\\usuarios\\persoais\\profes\\sol --profile-path=\\\\dserver\\usuarios\\perfisWindows\\sol --Script-path=inicio.bat
samba-tool group addmembers g-usuarios sol
samba-tool group addmembers g-profes sol
samba-tool group addmembers g-dam1-profes sol
samba-tool group addmembers g-dam2-profes sol

samba-tool user create noe abc123. --given-name=Noe --surname=Ras --userou=OU=profes,OU=usuarios --uid-number=10001 --home-drive=Z: --home-directory=\\\\dserver\\usuarios\\persoais\\profes\\noe --profile-path=\\\\dserver\\usuarios\\perfisWindows\\noe --Script-path=inicio.bat
samba-tool group addmembers g-usuarios noe
samba-tool group addmembers g-profes noe
samba-tool group addmembers g-dam1-profes noe
samba-tool group addmembers g-dam2-profes noe
