FROM quay.io/wildfly/wildfly:26.1.3.Final-jdk11

USER root

# Limites de memória seguros para o plano gratuito (512MB RAM)
ENV JAVA_OPTS="-Xms128m -Xmx384m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=128m -Dfile.encoding=UTF-8"

# Driver JDBC do PostgreSQL para ligar ao Supabase
RUN curl -L -o /opt/jboss/wildfly/standalone/deployments/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.7.3.jar

# Módulo principal unificado do SIGA (Processos, Corporativo e Serviços Web)
RUN curl -L -o /opt/jboss/wildfly/standalone/deployments/siga.war https://github.com/trf2/siga/releases/download/v11.5.0/siga.war || true

EXPOSE 8080

USER jboss

CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
