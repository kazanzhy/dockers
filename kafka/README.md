## Apache Kafka 
### Docker image
Base image Debian and contains following services inside:
* Apache Kafka Broker (Kraft Mode);
* Apache Kafka Connect;

Either build image:
```shell
# Clone repo  
git clone git@github.com:kazanzhy/dockers.git
cd dockers/kafka  

# Change configs in configs/
# Put Kafka Connect plugins to plugins/confluent-avro-converter/
# Put Kafka Connect configs to conf/confluent-avro-converter/

# Build the new image
docker build -t kazanzhy/kafka .
```
Or get image with default configs from Docker Hub:
```shell
docker pull kazanzhy/kafka:latest
```
Run Kafka:
```shell
docker run -d -p 9092:9092 --name kafka_app -v $(pwd)/shared:/home/kafka/shared kazanzhy/kafka
```

Interact with container:
```shell
docker exec -it kafka_app bash
```

Start/Stop/Remove container:
```
docker (start | stop | rm) kafka_app
```

### Docker Compose
Use all services in one container may be not productive.   
For the much better performance use these services in separate containers and run using **Docker Compose**.  
```
git clone git@github.com:kazanzhy/dockers.git
cd dockers/kafka
docker-compose docker-compose.yaml up
```
It runs separate containers with:
* Kafka Broker instance;
* Kafka Connect instance;
* Kafka Streams instance;
* Kafka Schema Registry instance;
* Kafka REST Proxy instance;
* ksqlDB server instance;
* ksqlDB CLI instance;

All images are provided by Confluent platform. Better to use compose files from the official Confluent repo "**cp-all-in-one**"

### Links
- Images on my [Docker Hub](https://hub.docker.com/u/kazanzhy).
- Confluent repository [cp-all-in-one](https://github.com/confluentinc/cp-all-in-one).