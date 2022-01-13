#!/bin/bash
./01_samba_install.sh
./02_ou.sh
./03_crear_grupos.sh group.dat
./04_crear_usuarios.sh usuarios.dat
./05_crear_esqueleto_RAID.sh
./05_crear_esqueleto.sh f05_cursos.txt
./06_configuración_nslcd.sh
./07_mddomadm.sh
./08_ajustar_acl.sh
./09_ajuste_comparticion_samba.sh
