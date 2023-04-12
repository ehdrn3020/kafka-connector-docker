# 실행
### 백그라운드 실행
docker-compose -f docker-compose.yaml up -d
### yaml수정 값, 컨테이너에 재적용
docker-compose -f docker-compose.yaml up --build --force-recreate -d

# 확인
### docker ps
### docker logs ${CONTAINER ID}


# 카프카 테스트
### process console 접속
docker exec -u root -it kafka-connector-docker-kafka-1 bash
### kafka topic 생성 및 확인
kafka-topics --create --topic my-topic --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1
kafka-topics --describe --topic my-topic --bootstrap-server kafka:9092
### 다른 방법
docker-compose exec kafka kafka-topics --create --topic my-topic --bootstrap-server kafka:9092 --replication-factor 1 --partitions 1
### consumer 실행 
kafka-console-consumer --topic my-topic --bootstrap-server kafka:9092
### producer 실행
kafka-console-producer --topic my-topic --broker-list kafka:9092