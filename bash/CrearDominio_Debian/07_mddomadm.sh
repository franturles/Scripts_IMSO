#!/bin/bash
#INSTALAMOS LAS LBL-TOOLS NECESARIAS PARA CREAR LAS UNIDADES ORGRANITIVAS
apt-get update && apt-get install ldb-tools -y

ldbmodify -H /var/lib/samba/private/sam.ldb 07_moddomadm.ldif

