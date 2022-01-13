#!/bin/bash

#Chamar ao script de variables
. ./05_crear_esqueleto_variables.sh # Tamén podería ser: source ./00_variables.sh
#DIR_USUARIOS=/datos/usuarios
#DIR_COMUN=/datos/comun
mount -a
#Establecemos de forma recursiva os permisos de Linux
#Hacemos propietario del arbol de usuarios al usuario y grupo ROOT
chown -R root:root $DIR_USUARIOS
#Damos permisos RWX para el grupo y propietario ROOT
chmod -R 770 $DIR_USUARIOS
#Hacemos propietario del arbol de usuarios al usuario y grupo ROOT
chown -R root:root $DIR_COMUN
chmod -R 770 $DIR_COMUN

#Cartafol de usuarios e subcartafoles
setfacl -m g:g-usuarios:rx $DIR_USUARIOS
setfacl -m g:"Domain Admins":rwx $DIR_USUARIOS
setfacl -m g:g-usuarios:rx $DIR_USUARIOS/persoais
setfacl -m g:"Domain Admins":rwx $DIR_USUARIOS/persoais
setfacl -dm g:"Domain Admins":rwx $DIR_USUARIOS/persoais
setfacl -m g:g-usuarios:rwx $DIR_USUARIOS/perfisWindows
setfacl -m g:g-usuarios:rwx $DIR_USUARIOS/perfisLinux

#Cartafol profes
setfacl -m g:"Domain Admins":rwx $DIR_USUARIOS/persoais/profes
setfacl -m g:g-profes:rx $DIR_USUARIOS/persoais/profes
setfacl -dm o:--- $DIR_USUARIOS/persoais/profes
setfacl -dm g::--- $DIR_USUARIOS/persoais/profes

#Cartafol alumnos
setfacl -m g:"Domain Admins":rwx $DIR_USUARIOS/persoais/alumnos
setfacl -m g:g-profes:rx $DIR_USUARIOS/persoais/alumnos
setfacl -m g:g-alum:rx $DIR_USUARIOS/persoais/alumnos

#Cartafoles cursos
for CURSO in $(cat f05_cursos.txt)
do
        setfacl -m g:g-$CURSO-alum:rx $DIR_USUARIOS/persoais/alumnos/$CURSO
        setfacl -m g:g-$CURSO-profes:rx $DIR_USUARIOS/persoais/alumnos/$CURSO
        setfacl -dm g:g-$CURSO-profes:rx $DIR_USUARIOS/persoais/alumnos/$CURSO
        setfacl -dm o:--- $DIR_USUARIOS/persoais/alumnos/$CURSO
        setfacl -dm g::--- $DIR_USUARIOS/persoais/alumnos/$CURSO
done

#Cartafol comun
setfacl -m g:g-profes:rx $DIR_COMUN
setfacl -m g:g-alum:rx $DIR_COMUN

#Subcartafol departamentos
setfacl -m g:g-profes:rwx $DIR_COMUN/departamentos
setfacl -dm g:g-profes:rwx $DIR_COMUN/departamentos

#Subcartafoles cursos
# O participante no curso á vista do esquema de permisos
# do exemplo de arriba debe ser quen de axustar
# os permisos de comun/cursos
#Cartafoles cursos
for CURSO in $(cat f05_cursos.txt)
do
        setfacl -m g:g-$CURSO-alum:rx $DIR_COMUN/$CURSO
        setfacl -m g:g-$CURSO-profes:rwx $DIR_COMUN/$CURSO
        setfacl -dm g:g-$CURSO-alum:rx $DIR_COMUN/$CURSO
        setfacl -dm g:g-$CURSO-profes:rwx $DIR_COMUN/$CURSO
done
