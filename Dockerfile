FROM jboss/wildfly:18.0.1.Final

USER root

# Define formalmente a porta 8080 para o proxy do Render
ENV PORT=8080

# Limites estritos de memória para caber nos 512MB
ENV JAVA_OPTS="-server -Xms64m -Xmx256m -XX:MetaspaceSize=64M -XX:MaxMetaspaceSize=128m -XX:+UseSerialGC -Dfile.encoding=UTF-8"

# Driver JDBC PostgreSQL
RUN curl -f -L -o /opt/jboss/wildfly/standalone/deployments/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.7.3.jar

# siga.war oficial v11.0.2.13
RUN curl -f -L -o /opt/jboss/wildfly/standalone/deployments/siga.war https://github.com/projeto-siga/siga/releases/download/v11.0.2.13/siga.war

EXPOSE 8080

USER jboss

# Sobe o servidor vinculando apenas a porta HTTP pública (0.0.0.0:8080)
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
