Cafe in Docker
==============

### Como executar

```console
$ docker-compose up -d --build
```

para acessar o eid e o eid2ldap:

EID - http://dominio:8080/eid
EID2LDAP - http://dominio:8080/eid2ldap

### Arquivos que devem ser alterados de acordo com a IFES

docker-compose.yml (senha root do mysql)
eid/Dockerfile (timezone)
eid/files/eid2ldap.xml (senha root do mysql)
eid/files/tomcat-users.xml (senhas para acesso ao eid e eid2ldap)
ldap/files/ldap.conf (base do ldap)
ldap/files/slapd.conf (base do ldap e usuarios do ldap)
shibboleth/Dockerfile (senha shibboleth e dominios)
shibboleth/files/idp.properties.dist (dominio e senha shibboleth)
shibboleth/files/ldap.properties.dist (credenciais do ldap)
shibboleth/files/idp-metadata.xml (dominio, nome da IFES, nome e email de contato)
shibboleth/files/saml-nameid.properties.dist (salt)
shibboleth/files/edit-webapp/images/logo-instituicao.png (logo da IFES)

### Arquivos que devem ser adicionados

ldap/files/cafe.key (chave privada ssl)
ldap/files/cafe.crt (chave pública ssl)
shibboleth/files/credentials/idp.key (chave privada ssl CAFe - RNP)
shibboleth/files/credentials/idp.crt (chave pública ssl CAFe - RNP)

### Demais requisitos

- criar usuário cn=leitor-shib,dc=... no LDAP.
- editar mensagens nos arquivos da pasta messages

### Banco de dados MySQL

no banco MySQL executar os seguintes comandos para criar e popular os bancos do eid e pcollecta:

```console
docker cp eid/sql/eid-1.3.7.dump cafe_mysql:/
docker cp eid/sql/eid2ldap-1.2.0.sql cafe_mysql:/
docker cp eid/sql/pcollecta-1.3.7.dump cafe_mysql:/

docker exec -it cafe_mysql bash
mysql -u root -p -e 'create database eid'
mysql -u root -p -e 'create database eid2ldap'
mysql -u root -p -e 'create database pcollecta'
mysql -u root -p eid < eid-1.3.7.dump
mysql -u root -p eid2ldap < eid2ldap-1.2.0.sql
mysql -u root -p pcollecta < pcollecta-1.3.7.dump
```

### Outros problemas e cenários

- no primeiro acesso do EID, insira a senha do banco mysql em Configuration > Data Repository > Alterar
- no primeiro acesso do EID2LDAP, altere o usuário do admin do ldap e a senha em Configuração > Servidor LDAP > Alterar
- caso você já possua uma instalação LDAP, pode simplesmente transferir o conteúdo da pasta /var/lib/ldap para o volume do container do ldap.
- caso não possua uma instalação LDAP, é necessário alterar a senha do usuário admin e do usuário shibboleth e o domínio no arquivo ldap/files/popula.sh.
