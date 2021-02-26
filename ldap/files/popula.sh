#!/bin/bash

#senhas
DOMINIO_INST="example.com"

RAIZ_BASE_LDAP="dc="`echo $DOMINIO_INST | sed -e 's/\./,dc=/g'`
ORGANIZACAO="`echo $RAIZ_BASE_LDAP | sed -e 's/^dc=//; s/,dc=/./'`"
DC="`echo $ORGANIZACAO | sed 's/^\.//; s/\..*$//'`"

SENHA_ADMIN="1234"
SENHA_LEITOR_SHIB="00123456"
HASH_SENHA_ADMIN=$( slappasswd -h {SSHA} -u -s $SENHA_ADMIN )
HASH_SENHA_LEITOR_SHIB=$( slappasswd -h {SSHA} -u -s $SENHA_LEITOR_SHIB )


cat <<-EOF | slapadd
dn: $RAIZ_BASE_LDAP
objectClass: top
objectClass: dcObject
objectClass: organization
o: $ORGANIZACAO
dc: $DC

dn: ou=people,$RAIZ_BASE_LDAP
objectClass: organizationalUnit
objectClass: top
ou: people

dn: uid=00123456,ou=people,$RAIZ_BASE_LDAP
objectClass: person
objectClass: inetOrgPerson
objectClass: brPerson
objectClass: schacPersonalCharacteristics
uid: 00123456
brcpf: 12345678900
brpassport: A23456
schacCountryOfCitizenship: Brazil
telephoneNumber: +55 12 34567890
mail: 00123456@$DOMINIO_INST
cn: Joao
sn: Silva
userPassword: $SENHA_00123456
schacDateOfBirth:19000523

dn: braff=1,uid=00123456,ou=people,$RAIZ_BASE_LDAP
objectclass: brEduPerson
braff: 1
brafftype: aluno-graduacao
brEntranceDate: 20070205

dn: braff=2,uid=00123456,ou=people,$RAIZ_BASE_LDAP
objectclass: brEduPerson
braff: 2
brafftype: professor
brEntranceDate: 20070205
brExitDate: 20080330

dn: brvoipphone=1,uid=00123456,ou=people,$RAIZ_BASE_LDAP
objectclass: brEduVoIP
brvoipphone: 1
brEduVoIPalias: 2345
brEduVoIPtype: pstn
brEduVoIPadmin: uid=00123456,ou=people,$RAIZ_BASE_LDAP
brEduVoIPcallforward: +55 22 3418 9199
brEduVoIPaddress: 200.157.0.333
brEduVoIPexpiryDate:  20081030
brEduVoIPbalance: 295340
brEduVoIPcredit: 300000

dn: brvoipphone=2,uid=00123456,ou=people,$RAIZ_BASE_LDAP
objectclass: brEduVoIP
brvoipphone: 2
brvoipalias: 2346
brEduVoIPtype: celular
brEduVoIPadmin: uid=00123456,ou=people,$RAIZ_BASE_LDAP

dn: brbiosrc=left-middle,uid=00123456,ou=people,$RAIZ_BASE_LDAP
objectclass: brBiometricData
brbiosrc: left-middle
brBiometricData: ''
brCaptureDate: 20001212

dn: cn=admin,$RAIZ_BASE_LDAP
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: admin
description: Administrador da base LDAP
userPassword: $HASH_SENHA_ADMIN

dn: cn=leitor-shib,$RAIZ_BASE_LDAP
objectClass: simpleSecurityObject
objectClass: organizationalRole
cn: leitor-shib
description: Leitor da base para o shibboleth
userPassword: $HASH_SENHA_LEITOR_SHIB
EOF

echo "[INFO] popula.sh finished execution"
