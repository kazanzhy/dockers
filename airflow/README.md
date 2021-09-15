## Apache Airflow 
### Docker image
Base image Debian with the latest Python. Airflow is configured with "LocalExecutor". 
Image contains following services inside:
- Apache Airflow (latest): webserver and scheduler;
- PostgreSQL (latest);

Either build image:
```shell
# Clone repo  
git clone git@github.com:kazanzhy/dockers.git
cd dockers/airflow  

# Change config files if needed
gedit airflow.cfg

# Build the new image
docker build -t kazanzhy/airflow .
```
Or get image with default configs from Docker Hub:
```shell
docker pull kazanzhy/airflow:latest
```
Run Airflow:
```shell
docker run -d -p 8080:8080 --name airflow_app -v $(pwd)/dags:/home/airflow/dags kazanzhy/airflow
```
Run Airflow mounted to existing PGDATA:
```shell
docker run -d -p 8080:8080 --name airflow_app -v dags:/home/airflow/dags -v /../pgdata:/home/app/pgdata kazanzhy/airflow
```
Follow and use login `admin` and password `admin`:  
http://localhost:8080  

Interact with container:
```shell
docker exec -it airflow_app bash
```

Start/Stop/Remove container:
```
docker (start | stop | rm) airflow_app
```

### Docker Compose
Use all services in one container may be not productive.   
For the much better performance use these services in separate containers and run using **Docker Compose**.  
```
git clone git@github.com:kazanzhy/dockers.git
cd dockers/airflow
docker-compose docker-compose.yaml up
```
It runs separate containers with:
* Apache Airflow webserver;
* Apache Airflow scheduler;
* Postgres server;

This `docker-compose.yaml` is a slightly simpler variant of the official one:  
https://github.com/apache/airflow/blob/master/docker-compose.yml

### Links
- Images on my [Docker Hub](https://hub.docker.com/u/kazanzhy).