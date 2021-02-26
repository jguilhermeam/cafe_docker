FROM tomcat:7-jdk8
MAINTAINER jgam@ufam.edu.br

ENV JAVA_HOME=/usr/local/openjdk-8
EXPOSE 8443

COPY files /tmp/

RUN cd /tmp/ && tar -xzf shibboleth-identity-provider-3.2.1-rnp.tgz; \
    mv /tmp/ldap.properties.dist /tmp/shibboleth-identity-provider-3.2.1-rnp/dist/conf/; \
    mv /tmp/idp.properties.dist /tmp/shibboleth-identity-provider-3.2.1-rnp/dist/conf/; \
    mv /tmp/saml-nameid.properties.dist /tmp/shibboleth-identity-provider-3.2.1-rnp/dist/conf/; \
    /tmp/shibboleth-identity-provider-3.2.1-rnp/bin/install.sh \
       -Didp.src.dir=/tmp/shibboleth-identity-provider-3.2.1-rnp \
       -Didp.target.dir=/opt/shibboleth-idp \
       -Didp.sealer.password=SENHA_SHIB \
       -Didp.keystore.password=SENHA_SHIB \
       -Didp.conf.filemode=644 \
       -Didp.host.name=DOMINIO.example.com \
       -Didp.scope=example.com \
       -Didp.entityID=https://DOMINIO.example.com/idp/shibboleth; \
    cp -rp /tmp/credentials /opt/shibboleth-idp/; \
    mv /tmp/idp-metadata.xml /opt/shibboleth-idp/metadata/; \
    mv /tmp/attribute-resolver.xml /opt/shibboleth-idp/conf/; \
    mv /tmp/metadata-providers.xml /opt/shibboleth-idp/conf/; \
    mv /tmp/attribute-filter.xml /opt/shibboleth-idp/conf/; \
    cp -rp /tmp/edit-webapp /opt/shibboleth-idp/; \
    cp -rp /tmp/views /opt/shibboleth-idp/; \
    cp -rp /tmp/messages /opt/shibboleth-idp/; \
    mkdir -p /usr/local/tomcat/conf/Catalina/localhost; \
    mv /tmp/idp.xml /usr/local/tomcat/conf/Catalina/localhost/; \
    mv /tmp/server.xml /usr/local/tomcat/conf/
