NEW-ADOrganizationalUnit -name Clientes -path "dc=exflf,dc=local"
NEW-ADOrganizationalUnit -name Usuarios -path "dc=exflf,dc=local"
NEW-ADOrganizationalUnit -name Administracion -path "ou=Usuarios,dc=exflf,dc=local"
NEW-ADOrganizationalUnit -name Direccion -path "ou=Usuarios,dc=exflf,dc=local"
NEW-ADOrganizationalUnit -name Administracion -path "ou=Clientes,dc=exflf,dc=local"
NEW-ADOrganizationalUnit -name Direccion -path "ou=Clientes,dc=exflf,dc=local"