#!/bin/bash


. ./05_crear_esqueleto_variables.sh

#Por se executamos o script varias veces, comprobamos se xa existe o directorio
test -d $DIR_USUARIOS/persoais/profes || mkdir -p $DIR_USUARIOS/persoais/profes

#Crear esqueleto para os perfis de Windows
test -d $DIR_USUARIOS/perfisWindows || mkdir -p $DIR_USUARIOS/perfisWindows

#Crear esqueleto para os perfis de Linux
test -d $DIR_USUARIOS/perfisLinux || mkdir -p $DIR_USUARIOS/perfisLinux


#Crear esqueleto alumnos e comun
#Lemos o ficheiro cursos e procesamos cada curso
for CURSO in $(cat f05_cursos.txt)
do
        test -d $DIR_USUARIOS/persoais/alumnos/$CURSO || mkdir -p $DIR_USUARIOS/persoais/alumnos/$CURSO
        test -d $DIR_COMUN/$CURSO || mkdir -p $DIR_COMUN/$CURSO
done

#Crear en comun a carpeta para os departamentos
test -d $DIR_COMUN/departamentos || mkdir -p $DIR_COMUN/departamentos

#Instalacion ACL
apt install acl -y

#Comprobacion
apt install tree -y
tree /Datos
