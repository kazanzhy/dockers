FROM python:latest
LABEL maintainer="Dmytro Kazanzhy"

ARG DEBIAN_FRONTEND="noninteractive"
ARG AIRFLOW="/home/airflow"

# Copy files
COPY ./requirements.txt $AIRFLOW/
COPY ./airflow.cfg $AIRFLOW/
COPY ./start-up.sh $AIRFLOW/
COPY ./dags/ $AIRFLOW/dags

# Set Envinronment
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 \
    PGDATA="/var/lib/postgresql/data/pgdata" \
    PYTHONPATH=$AIRFLOW:$AIRFLOW/dags \
    AIRFLOW_HOME=$AIRFLOW \
    AIRFLOW_PORT=8080 \
    AIRFLOW__CORE__SQL_ALCHEMY_CONN="postgresql+psycopg2://airflow:airflow@localhost:5432/airflow" \
    AIRFLOW__CORE__EXECUTOR="LocalExecutor" \
    AIRFLOW__CORE__LOAD_EXAMPLES=false

# Install soft
RUN apt-get update && \
    apt-get install -y --no-install-recommends freetds-bin krb5-user ldap-utils libffi7 libsasl2-2 libsasl2-modules libssl1.1 lsb-release sasl2-bin sqlite3 unixodbc locales && \
    apt-get install -y --no-install-recommends libsasl2-dev libldap2-dev libssl-dev && \
    apt-get install -y postgresql && \
    apt-get autoremove -yqq --purge && \
    apt-get clean -s && \
    rm -rf /var/lib/apt/lists && \
    python3 -m pip install --no-cache-dir -r $AIRFLOW/requirements.txt

# Setup database and Airflow
RUN mkdir -p $PGDATA &&  \
    chown postgres:postgres -R $PGDATA && \
    chmod -R 777 $PGDATA && \
    export PATH="$(pg_config --bindir):$PATH" && \
    su -p postgres -c 'pg_ctl initdb' && \
    su -p postgres -c 'pg_ctl start' && \
    su -p postgres -c 'psql -c "CREATE ROLE airflow WITH LOGIN PASSWORD '\''airflow'\'';"' && \
    su -p postgres -c 'psql -c "CREATE DATABASE airflow;"' && \
    su -p postgres -c 'psql -c "ALTER DATABASE airflow OWNER TO airflow;"' && \
    airflow db init && \
    airflow users create -u admin -p admin -f Airflow -l Admin -r Admin -e admin@fab.org && \
    airflow db upgrade && \
    su -p postgres -c "pg_ctl stop -m smart"

WORKDIR $AIRFLOW

USER root

VOLUME $AIRFLOW $PGDATA

EXPOSE $AIRFLOW_PORT

HEALTHCHECK CMD curl -f "http://localhost:8080/health"

ENTRYPOINT ["/bin/bash"]

CMD ["start-up.sh"]