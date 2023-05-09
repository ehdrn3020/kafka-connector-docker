FROM bitnami/kafka:3.4.0
USER root
RUN apt-get update && apt-get install -y vim

# confluent-hub download
RUN mkdir -p /confluent/component /confluent/config
RUN touch /confluent/config/work.properties

RUN apt-get install wget
RUN wget -P confluent http://client.hub.confluent.io/confluent-hub-client-latest.tar.gz
RUN tar xvzf confluent/confluent-hub-client-latest.tar.gz -C /confluent
RUN confluent/bin/confluent-hub install --no-prompt jcustenborder/kafka-connect-spooldir:latest --component-dir confluent/component --worker-configs confluent/config/work.properties

## Relative jar file for kafka-connect-spooldir
RUN wget -P /confluent/component/jcustenborder-kafka-connect-spooldir/lib https://repo1.maven.org/maven2/com/google/guava/guava/30.1.1-jre/guava-30.1.1-jre.jar
RUN cp /confluent/component/jcustenborder-kafka-connect-spooldir/lib/* /opt/bitnami/kafka/libs

RUN mkdir /home/data /home/error /home/finished