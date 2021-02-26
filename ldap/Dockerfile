FROM ubuntu:20.04

RUN apt update; \
    echo "slapd slapd/no_configuration boolean true" | debconf-set-selections; \
    apt-get -y install slapd ldap-utils; \
    mkdir -p /var/lib/ldap

COPY files /tmp/

RUN mv /tmp/slapd /etc/default/; \
    mv /tmp/slapd.conf /etc/ldap/; \
    mv /tmp/ldap.conf /etc/ldap/; \
    mv /tmp/eduperson.schema /etc/ldap/schema/; \
    mv /tmp/breduperson.0.0.6.schema /etc/ldap/schema/; \
    mv /tmp/schac-20061212-1.3.0 /etc/ldap/schema; \
    mv /tmp/samba.schema /etc/ldap/schema; \
    mv /tmp/DB_CONFIG /var/lib/ldap; \
    mv /tmp/cafe.key /etc/ldap; \
    mv /tmp/cafe.crt /etc/ldap; \
    mv /tmp/entrypoint.sh /; \
    chmod +x /entrypoint.sh

VOLUME /var/lib/ldap
CMD /entrypoint.sh
