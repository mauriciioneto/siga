FROM quay.io/wildfly/wildfly:26.1.3.Final-jdk11

USER root

# Definir limites de memória para o escalão gratuito (512MB RAM)
ENV JAVA_OPTS="-Xms128m -Xmx384m -XX:MetaspaceSize=96M -XX:MaxMetaspaceSize=128m -Dfile.encoding=UTF-8"

# Descarregar o driver JDBC do PostgreSQL para ligar ao Supabase
RUN curl -o /opt/jboss/wildfly/standalone/deployments/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.7.3.jar

# Porta padrão de escuta HTTP
EXPOSE 8080

USER jboss

# Comando de arranque com ligação direta aos parâmetros de rede
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
