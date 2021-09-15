FROM debian:latest
LABEL maintainer="Dmytro Kazanzhy"

ARG DEBIAN_FRONTEND="noninteractive"
ARG SPARK="3.1.2"
ARG HADOOP="3.2"
ARG HOME="/home/spark"

# Copy loaded jars
COPY ./jars $HOME/jars
COPY ./start-up.sh /start-up.sh

# Set init Envinronment
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# Install soft
RUN apt-get update && \
    apt-get install -y default-jdk scala wget procps ssh && \
    apt-get autoremove -yqq --purge && \
    apt-get clean -s && \
    rm -rf /var/lib/apt/lists && \
    cd /home && \
    wget https://downloads.apache.org/spark/spark-$SPARK/spark-$SPARK-bin-hadoop$HADOOP.tgz && \
    tar -xvzf spark-$SPARK-bin-hadoop$HADOOP.tgz && \
    mv spark-$SPARK-bin-hadoop$HADOOP /opt/spark && \
    rm -rf /home/*

# Set full Envinronment
ENV PATH="$PATH:/opt/spark/bin:/opt/spark/sbin" \
    CLASSPATH="$CLASSPATH:$HOME/jars:/opt/spark/jars" \
    SPARK_HOME="/opt/spark" \
    SPARK_DAEMON_CLASSPATH="/opt/spark/jars" \
    SPARK_LOG_DIR="$HOME/logs" \
    SPARK_PID_DIR="$HOME/pids" \
    SPARK_LOCAL_DIRS="$HOME" \
    SPARK_MASTER_HOST="localhost" \
    SPARK_MASTER_PORT=7077 \
    SPARK_MASTER_WEBUI_PORT=7070 \
    SPARK_WORKER_WEBUI_PORT=8081 \
    SPARK_WORKER_DIR="$HOME/workers"

WORKDIR $HOME

USER root

VOLUME $HOME/jars

EXPOSE 8080 7077 7070

HEALTHCHECK CMD ps aux | grep -v grep | grep "org.apache.spark.deploy.master.Master"

ENTRYPOINT ["/bin/bash"]

CMD ["/start-up.sh"]