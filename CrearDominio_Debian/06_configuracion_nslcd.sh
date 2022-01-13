#!/bin/bash

DOMINIO=iesallerflf


sed -i "/^\[netlogon\]/i\\\tldap server require strong auth = no" /etc/samba/smb.conf 

systemctl stop samba-ad-dc
systemctl start samba-ad-dc

apt-get update && apt-get install nslcd -y

sed -i "s/^passwd/#&/" /etc/nsswitch.conf
sed -i "s/^group/#&/" /etc/nsswitch.conf
sed -i "s/^shadow/#&/" /etc/nsswitch.conf

sed -i "/^#shadow:/a\passwd:\\tfiles ldap\ngroup:\\tfiles ldap\nshadow:\\tfiles ldap" /etc/nsswitch.conf
echo "# Some settings for AD" >>/etc/nslcd.conf
echo "pagesize 1000" >> /etc/nslcd.conf
echo "referrals off">>/etc/nslcd.conf
echo >>/etc/nslcd.conf
echo "# Filters (only required if your accounts doesn't have objectClass=posixAccount">>/etc/nslcd.conf
echo "# and your groups haven't objectClass=posixGroup. This objectClasses won't be added">>/etc/nslcd.conf
echo "# by ADUC. So they won't be there automatically!)">>/etc/nslcd.conf
echo "filter  passwd  (objectClass=user)">>/etc/nslcd.conf
echo "filter  group   (objectClass=group)">>/etc/nslcd.conf
echo >>/etc/nslcd.conf 
echo "# Attribut mappings (depending on your nslcd version, some might not be" >>/etc/nslcd.conf
echo "# necessary or can cause errors and can/must be removed)" >>/etc/nslcd.conf
echo "map     passwd  uid                sAMAccountName" >> /etc/nslcd.conf
echo "map     passwd  homeDirectory      unixHomeDirectory" >> /etc/nslcd.conf
echo "map     passwd  gecos              displayName" >> /etc/nslcd.conf
echo "map     passwd  gidNumber          primaryGroupID" >> /etc/nslcd.conf
echo >> /etc/nslcd.conf
echo "# LDAP bind (Account in AD that is used from nslcd to bind to the directory)" >>/etc/nslcd.conf
echo "binddn cn=Administrator,cn=Users,dc=$DOMINIO,dc=local" >>/etc/nslcd.conf
echo "bindpw abc123." >>/etc/nslcd.conf

systemctl restart nslcd.service
#service nslcd restart

