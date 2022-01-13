#!/bin/bash

#Variables
DEVRAID=/dev/md0
DISCO1=/dev/sdb
DISCO2=/dev/sdc
MONTAJE=/Datos

#Actualizamos y Instalamos MDADM
apt update && apt upgrade -y
apt install mdadm -y --no-install-recommends

#Copia de seguridad de FSTAB
cp /etc/fstab /etc/fstab.backup

#Creamos RAID
mdadm --create $DEVRAID --level=1 --raid-devices=2 $DISCO1 $DISCO2


#Formatear RAID
mkfs.ext4 $DEVRAID -L Datos

#Cogemos el UUID del RAID
uuid=$(blkid | grep "^$DEVRAID"|cut -d" " -f3|tr -d '"')

#Crear punto de montaje
test -d $MONTAJE | mkdir $MONTAJE

#Añadir entrada en fstab
echo "$uuid $MONTAJE ext4 user_xattr,acl 0 0" >> /etc/fstab

#Remontamos todos los sistemas de archivos
clear
mount -a

#Pruebas
cat /proc/mdstat
mdadm --detail $DEVRAID
