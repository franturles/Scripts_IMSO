#!/bin/bash

# Define variable globais que van usar os demais scripts

#Variables
DIR_USUARIOS=/Datos/usuarios
DIR_COMUN=/Datos/comun
# Exportar variables
# Nos scripts que se van usar a continuación non faría falla que se exportasen as variables.
# Pero quedan exportadas por se a posteriori calquera dos scripts que vai importar
# o contido deste ficheiro precisase chamar a outros scripts que precisasen usar estas variables
export DIR_USUARIOS
export DIR_COMUN
