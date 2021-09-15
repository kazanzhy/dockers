FROM debian:latest
LABEL maintainer="Dmytro Kazanzhy"

ARG DEBIAN_FRONTEND="noninteractive"
ARG SCALA="2.13"
ARG SCALAV="2.13.6"
ARG KAFKA="3.0.0"
ARG HOME="/home/kafka"
#
# Copy files
COPY ./shared $HOME/shared
COPY ./start-up.sh /start-up.sh

# Set init Envinronment
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8 HOME=$HOME

# Install soft     #  ssh && \
RUN cd $HOME && \
    apt-get update && \
    apt-get install -y default-jdk wget && \
    wget www.scala-lang.org/files/archive/scala-$SCALAV.deb && \
    dpkg -i scala-$SCALAV.deb && \
    rm -f scala-$SCALAV.deb && \
    wget https://dlcdn.apache.org/kafka/$KAFKA/kafka_$SCALA-$KAFKA.tgz && \
    tar -xvzf kafka_$SCALA-$KAFKA.tgz && \
    mv kafka_$SCALA-$KAFKA /opt/kafka && \
    rm -f kafka_$SCALA-$KAFKA.tgz && \
    apt-get remove -y wget && \
    apt-get autoremove -yqq --purge && \
    apt-get clean -s && \
    rm -rf /var/lib/apt/lists

# Set full Envinronment
ENV PATH="$PATH:/opt/kafka/bin" \
    CLASSPATH="$CLASSPATH:$HOME/shared/plugins:/opt/kafka/libs"

WORKDIR $HOME

USER root

VOLUME $HOME/jars

EXPOSE 9092

HEALTHCHECK CMD /opt/kafka/bin/kafka-broker-api-versions.sh --bootstrap-server localhost:9092

ENTRYPOINT ["/bin/bash"]

CMD ["/start-up.sh"]