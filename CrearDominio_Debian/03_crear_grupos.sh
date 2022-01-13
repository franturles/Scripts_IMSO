#!/bin/bash
#Crear Grupos
# for
#Variables:
dominio=$(cat /etc/resolv.conf |grep "^domain" | cut -d" " -f2)

for i in $(cat $1)
do
	GRUPO=$(echo $i | cut -f1 -d:)
	GIDNUMBER=$(echo $i | cut -f2 -d:)
	samba-tool group add $GRUPO --groupou=OU=grupos --gid-number=$GIDNUMBER --nis-domain=$dominio
done
