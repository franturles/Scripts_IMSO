#!/bin/bash
#VERSION PARA DEBIAN

##Variables
equipo="dserver00"
ip="172.16.5.10"

#Modificamos /etc/network/interface para la configuración de red
cp /etc/network/interfaces /etc/network/interfaces.old
sed -i "/^address/s/172.16.5.2/$ip/" /etc/network/interfaces

#modificamos el nombre de equipo
cp /etc/hostname /etc/hostname.old
hostname $equipo
sed -i "s/dbase/$equipo/" /etc/hostname

#modificamos /etc/hosts añadiendo la entrada para nuestro equipo
cp /etc/hosts /etc/hosts.old
sed -i "s/dbase/$equipo/" /etc/hosts

##reiniciamos la red
ip link set enp0s3 down
systemctl restart networking.service
ip link set enp0s3 up


