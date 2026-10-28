FROM jboss/wildfly:10.1.0.Final

USER root

# Limites de memória seguros para a cota de 512MB do Render
ENV JAVA_OPTS="-Xms128m -Xmx384m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=128m -Dfile.encoding=UTF-8"

# Driver JDBC do PostgreSQL compatível
RUN curl -f -L -o /opt/jboss/wildfly/standalone/deployments/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.2.27.jre7.jar

# Download direto do siga.war oficial (84.9 MB) da release v11.0.2.13
RUN curl -f -L -o /opt/jboss/wildfly/standalone/deployments/siga.war https://github.com/projeto-siga/siga/releases/download/v11.0.2.13/siga.war

EXPOSE 8080

USER jboss

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
