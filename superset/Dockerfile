FROM python:latest
LABEL maintainer="Dmytro Kazanzhy"

ARG DEBIAN_FRONTEND="noninteractive"
ARG SUPERSET="/home/superset"
ARG PORT=8088

# Copy files
COPY ./requirements.txt $SUPERSET/
COPY ./superset_config.py $SUPERSET/
COPY ./gunicorn_config.py $SUPERSET/
COPY ./run.sh $SUPERSET/

# Set Envinronment
ENV LANG=C.UTF-8 \
    LC_ALL=C.UTF-8 \
    FLASK_ENV="production" \
    FLASK_APP="superset.app:create_app()" \
    PYTHONPATH=$SUPERSET \
    SUPERSET_HOME=$SUPERSET \
    SUPERSET_PORT=8088

# Install soft
RUN apt-get update && \
    apt-get install -y build-essential libssl-dev libffi-dev libsasl2-dev libldap2-dev redis && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    python3 -m pip install --no-cache-dir -r $SUPERSET/requirements.txt

# Setup Superset
RUN superset db upgrade && \
    superset fab create-admin --username admin --password admin --firstname Superset --lastname Admin --email admin@fab.org && \
    superset init && \
    useradd -r -G root -s /bin/bash superset && \
    chown -R superset $SUPERSET && \
    chmod -R u+rwx $SUPERSET

WORKDIR $SUPERSET

USER superset

VOLUME $SUPERSET

EXPOSE $PORT

HEALTHCHECK CMD curl -f "http://localhost:$PORT/health"

ENTRYPOINT ["/bin/bash"]

CMD ["run.sh"]