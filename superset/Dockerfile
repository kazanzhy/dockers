FROM python:latest
LABEL maintainer="Dmytro Kazanzhy"

ARG DEBIAN_FRONTEND="noninteractive"
ARG SUPERSET="/home/superset"

# Copy files
COPY ./requirements.txt $SUPERSET/
COPY ./superset_config.py $SUPERSET/
COPY ./gunicorn_config.py $SUPERSET/
COPY ./start-up.sh $SUPERSET/

# Set Envinronment
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    PGDATA="/var/lib/postgresql/data/pgdata" \
    PYTHONPATH=$SUPERSET \
    FLASK_ENV="production" \
    FLASK_APP="superset.app:create_app()" \
    SUPERSET_HOME=$SUPERSET \
    SUPERSET_PORT=8088 \
    SUPERSET_CONFIG_PATH=$SUPERSET/superset_config.py

# Install soft
RUN apt-get update && \
    apt-get install -y build-essential libssl-dev libffi-dev libsasl2-dev libldap2-dev libpq-dev && \
    apt-get install -y postgresql redis && \
    apt-get clean -s && \
    rm -rf /var/lib/apt/lists && \
    python3 -m pip install --no-cache-dir -r $SUPERSET/requirements.txt

# Setup database and Superset
RUN mkdir -p $PGDATA &&  \
    chown postgres:postgres -R $PGDATA && \
    chmod -R 777 $PGDATA && \
    export PATH="$(pg_config --bindir):$PATH" && \
    su -p postgres -c 'pg_ctl initdb' && \
    su -p postgres -c 'pg_ctl start' && \
    su -p postgres -c 'psql -c "CREATE ROLE superset WITH LOGIN PASSWORD '\''superset'\'';"' && \
    su -p postgres -c 'psql -c "CREATE DATABASE superset;"' && \
    su -p postgres -c 'psql -c "ALTER DATABASE superset OWNER TO superset;"' && \
    superset db upgrade && \
    superset fab create-admin --username admin --password admin --firstname Superset --lastname Admin --email admin@fab.org && \
    superset init && \
    su -p postgres -c "pg_ctl stop -m smart"

WORKDIR $SUPERSET

USER root

VOLUME $SUPERSET $PGDATA

EXPOSE $SUPERSET_PORT

HEALTHCHECK CMD curl -f "http://localhost:8088/health"

ENTRYPOINT ["/bin/bash"]

CMD ["start-up.sh"]