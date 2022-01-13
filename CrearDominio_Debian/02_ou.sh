#!/bin/bash
#CREAMOS LAS OU
samba-tool ou create "OU=usuarios,DC=iesallerflf,DC=local" --description="OU Usuarios"
samba-tool ou create "OU=grupos,DC=iesallerflf,DC=local" --description="OU Grupos"
samba-tool ou create "OU=profes,OU=usuarios,DC=iesallerflf,DC=local" --description="OU Profes"
samba-tool ou create "OU=dam1,OU=profes,OU=usuarios,DC=iesallerflf,DC=local" --description="OU DAM1 Profes"
samba-tool ou create "OU=dam2,OU=profes,OU=usuarios,DC=iesallerflf,DC=local" --description="OU DAM2 Profes"
samba-tool ou create "OU=alumnos,OU=usuarios,DC=iesallerflf,DC=local" --description="OU Alumnos"
samba-tool ou create "OU=dam1,OU=alumnos,OU=usuarios,DC=iesallerflf,DC=local" --description="OU DAM1 Alumnos"
samba-tool ou create "OU=dam2,OU=alumnos,OU=usuarios,DC=iesallerflf,DC=local" --description="OU DAM2 Alumnos"
samba-tool ou create "OU=maquinas,DC=iesallerflf,DC=local" --description="OU Maquinas"
samba-tool ou create "OU=aula1,OU=maquinas,DC=iesallerflf,DC=local" --description="OU Aula1"

