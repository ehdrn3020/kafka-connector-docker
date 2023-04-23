FROM bitnami/kafka:3.4.0
USER root
RUN apt-get update && apt-get install -y vim
