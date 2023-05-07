FROM bitnami/kafka:3.4.0
USER root
RUN apt-get update && apt-get install -y vim
RUN apt-get install wget
RUN wget http://client.hub.confluent.io/confluent-hub-client-latest.tar.gz
RUN tar xzvf confluent-hub-client-latest.tar.gz
RUN confluent-hub install jcustenborder/kafka-connect-spooldir:latest

RUN mkdir confluent
RUN mkdir confluent/component
RUN mkdir confluent/config
RUN touch confluent/config/work.properties