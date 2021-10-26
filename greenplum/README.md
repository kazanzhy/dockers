## GreenplumDB
### Docker image
Base image Ubuntu and contains following services inside:
* GreenplumDB Master;


Either build image:
```shell
# Clone repo  
git clone git@github.com:kazanzhy/dockers.git
cd dockers/greenplum  

# Change configs in start.sh

# Build the new image
docker build -t kazanzhy/greenplum .
```
Or get image with default configs from Docker Hub:
```shell
docker pull kazanzhy/greenplum:latest
```
Run GreenplumDB:
```shell
docker run -d -p 54321:54321 --name greenplum_app kazanzhy/greenplum
```

Interact with container:
```shell
docker exec -it greenplum_app bash
```

Start/Stop/Remove container:
```
docker (start | stop | rm) greenplum_app
```

### Docker Compose
Use all services in one container may be not productive.   
For the much better performance use these services in separate containers and run using **Docker Compose**.  
```
git clone git@github.com:kazanzhy/dockers.git
cd dockers/greenplum
docker-compose docker-compose.yaml up
```
It runs separate containers with:
* Kafka Broker instance;

### Links
- Images on my [Docker Hub](https://hub.docker.com/u/kazanzhy).
