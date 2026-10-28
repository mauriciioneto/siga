FROM jboss/wildfly:18.0.1.Final

USER root

# Restrições de memória para não acionar o OOM (limite total de 512MB)
ENV JAVA_OPTS="-server -Xms64m -Xmx320m -XX:MetaspaceSize=64M -XX:MaxMetaspaceSize=128m -XX:+UseSerialGC -Dfile.encoding=UTF-8"

# Driver JDBC do PostgreSQL
RUN curl -f -L -o /opt/jboss/wildfly/standalone/deployments/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.7.3.jar

# Download do siga.war oficial da v11.0.2.13
RUN curl -f -L -o /opt/jboss/wildfly/standalone/deployments/siga.war https://github.com/projeto-siga/siga/releases/download/v11.0.2.13/siga.war

EXPOSE 8080

USER jboss

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
