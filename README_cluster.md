# Execution
### Background Execution
docker-compose -f docker-compose-cluster.yaml up -d
### Yaml file modifications, re-applying to containers
docker-compose -f docker-compose-cluster.yaml up --build --force-recreate -d   


# Kafka test
### Connect process console
docker exec -u root -it kafka-connector-docker-kafka1-1 bash
docker exec -u root -it kafka-connector-docker-kafka2-1 bash
docker exec -u root -it kafka-connector-docker-kafka3-1 bash

### Create kafka topic
cd /opt/bitnami/kafka/
bin/kafka-topics.sh --bootstrap-server localhost:9092 --list
bin/kafka-topics.sh --create --topic connect-test --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092 --replication-factor 3 --partitions 3
bin/kafka-topics.sh --describe --topic connect-test --bootstrap-server localhost:9092


# Kafka connect cluster test
### Run consumer
bin/kafka-console-consumer.sh --topic connect-test --bootstrap-server kafka1:9092,kafka2:9092,kafka3:9092

### add sample file in path
vi /home/data/test_file
>>> Example CSV
id,first_name,last_name,email,gender,ip_address,last_login,country,favorite_color
1,John,Smith,john.smith@example.com,male,192.0.2.1,1651792868,United States,blue
2,Jane,Doe,jane.doe@example.com,female,192.0.2.2,1651792868,Canada,green
3,Bob,Johnson,bob.johnson@example.com,male,192.0.2.3,1651792868,United Kingdom,red
4,Alice,Jones,alice.jones@example.com,female,192.0.2.4,1651792868,France,yellow

### execution
bin/connect-distributed.sh config/connect-distributed.properties config/connect-dir-source.properties

### check success & fail file
cat /home/finished/test_file/test_file
cat /home/error/test_file/test_file


# Reference URL
https://github.com/jcustenborder/kafka-connect-spooldir
https://docs.confluent.io/kafka-connectors/spooldir/current/connectors/csv_source_connector.html#spooldir-connector-csv-with-schema-example
