FROM tomcat:6

RUN apt update && apt install -y unzip build-essential openjdk-7-jdk

ENV VERSAO_EID=1.3.7 \
    JARO_WINKLER_DIR=/opt/eid-1.3.7/lib \
    JAVA_OPTS="-XX:MaxPermSize=512M -Xmx512M -Duser.timezone=America/Manaus -Duser.language=pt -Duser.country=BR -Djava.library.path=/opt/eid-1.3.7/lib -Dfile.encoding=UTF-8" \
    JRE_HOME=/usr/lib/jvm/java-7-openjdk-amd64 \
    JAVA_HOME=/usr/lib/jvm/java-7-openjdk-amd64

COPY files /tmp/

RUN mv /tmp/mysql-connector-java-5.1.48-bin.jar /usr/share/java/; \
    ln -sf /usr/share/java/mysql-connector-java-5.1.48-bin.jar /usr/local/tomcat/lib/; \
    mv /tmp/tomcat-dbcp.jar /usr/local/tomcat/lib/; \
    mkdir /opt/eid-1.3.7/; \
    unzip /tmp/eid.war -d /opt/eid-1.3.7/; \
    mkdir -p $JARO_WINKLER_DIR; \
    mv /tmp/Makefile /opt/eid-1.3.7/WEB-INF/classes/br/ufmg/lcc/eid/model/conciliator/; \
    cd /opt/eid-1.3.7/WEB-INF/classes/br/ufmg/lcc/eid/model/conciliator/ && make compile; \
    mkdir -p /usr/local/tomcat/conf/Catalina/localhost/; \
    mv /tmp/eid.xml /usr/local/tomcat/conf/Catalina/localhost/; \
    mv /tmp/eid2ldap.xml /usr/local/tomcat/conf/Catalina/localhost/; \
    mv /tmp/tomcat-users.xml /usr/local/tomcat/conf/; \
    mkdir -p /opt/eid2ldap-1.2.0/; \ 
    unzip /tmp/eid2ldap.war -d /opt/eid2ldap-1.2.0/
