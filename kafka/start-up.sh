#!/usr/bin/env sh
set -m;
cd $HOME || exit;

# Generate a cluster ID
kafka-storage.sh random-uuid > ./cluster.id

# Format Storage Directories
kafka-storage.sh format -t $(cat cluster.id) -c $HOME/shared/conf/server.properties

# Run Kafka broker in background
kafka-server-start.sh shared/conf/server.properties &
KAFKA_STATUS=$?; KAFKA_PID=$!;
echo "$(date) - Apache Kafka status=$KAFKA_STATUS, pid=$KAFKA_PID";

# Run Kafka Connect in background
connect-standalone.sh shared/conf/connect-worker.properties $(find shared/conf/connect -type f | xargs) &
CONNECT_STATUS=$?; CONNECT_PID=$!;
echo "$(date) - Apache Kafka Connect status=$CONNECT_STATUS, pid=$CONNECT_PID";

# Continuous monitoring
while sleep 60; do
  if [ -d /proc/${KAFKA_PID} ] || [ -d /proc/${CONNECT_PID} ]; then
    echo "$(date) - Apache Kafka services check:";
    [ -d /proc/${KAFKA_PID} ] && echo "Broker - OK" || echo "Broker - FAILED";
    [ -d /proc/${CONNECT_PID} ] && echo "Connect - OK" || echo "Connect - FAILED";
  else
    exit 1;
  fi;
done;