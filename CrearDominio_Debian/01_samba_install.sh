#!/bin/bash
#VARIABLES
Dominio="iesallerflf"
DOMINIO=$(echo "$Dominio" | tr [[:lower:]] [[:upper:]])
IP=$(hostname -I)
Maquina=$(hostname)

#Actualizamos y instalamos el ntp
apt-get update && apt-get upgrade && apt-get install ntp -y
sed -i "s/^pool/#&/" /etc/ntp.conf
sed -i "/^#pool 3/a\server 3.es.pool.ntp.org\nserver 1.europe.pool.ntp.org\nserver 2.europe.pool.ntp.org" /etc/ntp.conf
clear
cat /etc/ntp.conf
clear
systemctl restart ntp.service
ntpq -p

#Instalamos SAMBA
clear
apt-get install samba smbclient winbind -y
cp /etc/samba/smb.conf /etc/samba/smb.conf.old
rm /etc/samba/smb.conf


#Configurar SAMBA
cp /etc/resolv.conf /etc/resolv.conf.old
echo "domain $Dominio.local" > /etc/resolv.conf
echo "search $Dominio.local" >> /etc/resolv.conf
echo "nameserver $IP" >> /etc/resolv.conf
clear
cat /etc/resolv.conf

#Promocionar a controlador de dominio
apt remove bind9 -y
samba-tool domain provision --use-rfc2307 --realm=$DOMINIO.LOCAL --domain=$DOMINIO --server-role='dc' --dns-backend=SAMBA_INTERNAL --adminpass=abc123.

#Reenviador de DNS
sed -i "s/^\tdns/#&/" /etc/samba/smb.conf
sed -i "/#\tdns/a\\\tdns forwarder = 1.1.1.1" /etc/samba/smb.conf
sed -i "/^\tidmap/a\\\tallow dns updates = nonsecure" /etc/samba/smb.conf
cat  /etc/samba/smb.conf
clear
systemctl stop smbd nmbd winbind
systemctl disable smbd nmbd winbind
systemctl unmask samba-ad-dc
systemctl start samba-ad-dc
systemctl enable samba-ad-dc


#COMPROBACIONES
smbclient -L localhost -U%
host -t SRV _ldap._tcp.$Dominio.local
host -t SRV _kerberos._udp.$Dominio.local
host -t A $Maquina.$Dominio.local

#Instalar Kerberos
apt install krb5-user -y
sed -i "/^\tdefault_realm/a\\\tdns_lookup_realm = false" /etc/krb5.conf
sed -i "/^\tdns_lookup_realm/a\\\tdns_lookup_kdc = true" /etc/krb5.conf
sed -i "/^\[domain_realm\]/i\\\t$DOMINIO.LOCAL = {\\n\\t\\tkdc = $Maquina.$Dominio.local\\n\\t\\tadmin_server = $Maquina.$Dominio.local:749\\n\\t\\tdefault_domain = $Dominio.local\\n\\t\\t}" /etc/krb5.conf
sed -i "/^\[\domain_realm\]/a\\\t.$Dominio.local = $DOMINIO.LOCAL\\n\\t$Dominio.local = $DOMINIO.LOCAL" /etc/krb5.conf

#Pedimos Ticket a kerberos
kinit administrator
#Listado de tickets
klist -e
