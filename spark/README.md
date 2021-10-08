## Apache Airflow 
### Docker image
Base Debian image contains following services inside:
- Apache Spark Master;
- Apache Spark Slave (1: by default);

Either build image:
```shell
# Clone repo  
git clone git@github.com:kazanzhy/dockers.git
cd dockers/spark  

# Build the new image
docker build -t kazanzhy/spark .
```
Or get image with default configs from Docker Hub:
```shell
docker pull kazanzhy/spark:latest
```
Run Spark:
```shell
docker run -d -p 7077:7077 -p 7070:7070 --name spark_app kazanzhy/spark
```
Run Spark with additional jars, like JDBC:
```shell
docker run -d -p 7077:7077 -p 7070:7070 --name spark_app -v $(pwd)/jars:/home/spark/jars kazanzhy/spark
```
Follow: http://localhost:7070  
Connect: spark://localhost:7077

Interact with container:
```shell
docker exec -it spark_app bash
```

Start/Stop/Remove container:
```
docker (start | stop | rm) spark_app
```

### Docker Compose
Use all services in one container may be not productive.   
For the much better performance use these services in separate containers and run using **Docker Compose**.  
```
git clone git@github.com:kazanzhy/dockers.git
cd dockers/spark
docker-compose docker-compose.yaml up
```
It runs separate containers with:
* Apache Spark Master;
* Apache Spark Worker-1;

You can edit `docker-compose.yaml` and copy-paste more workers.

### Links
- https://spark.apache.org/docs/latest/spark-standalone.html
- Images on my [Docker Hub](https://hub.docker.com/u/kazanzhy).