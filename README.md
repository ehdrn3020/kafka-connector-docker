  
# Execution
### Background Execution
docker-compose -f docker-compose.yaml up -d
### Yaml file modifications, re-applying to containers
docker-compose -f docker-compose.yaml up --build --force-recreate -d   


# Check
docker ps
docker logs ${CONTAINER ID}   


# Path
### Execution file path 
/opt/bitnami/kafka/bin 
### Topic data path 
${BASE_DIR}/kafka-connector-docker/data/kafka/data/ : /bitnami/kafka/data
### Config file path 
${BASE_DIR}/kafka-connector-docker/kafka/config : /opt/bitnami/kafka/config   


# Kafka test
### Connect process console
docker exec -u root -it kafka-connector-docker-kafka-1 bash

### Create kafka topic
cd /opt/bitnami/kafka/
bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
kafka-topics.sh --create --topic connect-test --bootstrap-server localhost:9092 --replication-factor 1 --partitions 1
kafka-topics.sh --describe --topic connect-test --bootstrap-server localhost:9092

### Run consumer
kafka-console-consumer.sh --topic connect-test --bootstrap-server localhost:9092
### Run producer
kafka-console-producer.sh --topic connect-test --bootstrap-server localhost:9092   

### Get Segment
bin/kafka-dump-log.sh --print-data-log --files /bitnami/kafka/data/connect-test-0/00000000000000000000.log


# Kafka connect test
### make sure to add plugin file in path
echo -e "foo\nbar\nsoo" > /home/test.txt
bin/connect-standalone.sh config/connect-standalone.properties config/connect-file-source.properties config/connect-file-sink.properties
more test.sink.txt_


# Kafka direcotory connect
cd /opt/bitnami/kafka
bin/connect-standalone.sh config/connect-standalone.properties config/connect-dir-source.properties


# Reference URL
### Zookeeper Reference
https://hub.docker.com/r/bitnami/zookeeper
https://github.com/bitnami/containers/tree/main/bitnami/zookeeper

### Kafka Reference
https://hub.docker.com/r/bitnami/kafka
https://github.com/bitnami/containers/tree/main/bitnami/kafka
https://kafka.apache.org/quickstart

### Kafka Connect
https://kafka.apache.org/documentation/#connect