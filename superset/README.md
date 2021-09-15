## Apache Superset 
### Docker image
Base image Debian with the latest Python. Image contains following services inside:
- Apache Superset (latest)
- PostgreSQL (latest)
- Redis (latest)  

Either build image:
```shell
# Clone repo  
git clone git@github.com:kazanzhy/dockers.git
cd dockers/superset  

# Change config files if needed
gedit superset_config.py
gedit gunicorn_config.py

# Build the new image
docker build -t kazanzhy/superset .
```
Or get image with default configs from Docker Hub:
```shell
docker pull kazanzhy/superset:latest
```
Run Superset:
```shell
docker run -d -p 8088:8088 --name superset_app kazanzhy/superset
```
Run Superset mounted to existing PGDATA:
```shell
docker run -d -p 8088:8088 --name superset_app -v /../pgdata:/home/app/pgdata kazanzhy/superset
```
Follow and use login `admin` and password `admin`:  
http://localhost:8088  

Interact with container:
```shell
docker exec -it superset_app bash
```

Start/Stop/Remove container:
```
docker (start | stop | rm) superset_app
```

### Docker Compose
Use all services in one container may be not productive.   
For the much better performance use these services in separate containers and run using **Docker Compose**.  
```
git clone git@github.com:kazanzhy/dockers.git
docker-compose docker-compose.yaml up
```
Docker Compose starts following services in separate containers from Docker Hub:
- Apache Superset (latest)
- PostgreSQL (latest)
- Redis (latest)  

This `docker-compose.yaml` is a slightly simpler variant of the official one:  
https://github.com/apache/superset/blob/master/docker-compose.yml

### Links
- [Database drivers](https://superset.apache.org/docs/databases/installing-database-drivers) list to put to requirements;
- Default [Superset config](https://github.com/apache/superset/blob/master/superset/config.py);
- Gunicorn [Configuration Overview](https://docs.gunicorn.org/en/stable/configure.html)
- Images on my [Docker Hub](https://hub.docker.com/u/kazanzhy).