#!/usr/bin/env bash
set -m;

# Start Master
source /opt/spark/sbin/start-master.sh;

# Start Worker
source /opt/spark/sbin/start-worker.sh spark://localhost:7077

# Continuous monitoring
while sleep 60; do
  ps aux | grep "org.apache.spark.deploy.master.Master" | grep -q -v "grep";
  MASTER_STATUS=$?;
  echo "$(date) - Spark Master: status=$MASTER_STATUS";

  ps aux | grep "org.apache.spark.deploy.worker.Worker" | grep -q -v "grep";
  WORKER_STATUS=$?; PID=$!;
  echo "$(date) - Spark Slave: status=$WORKER_STATUS";

  if [ $MASTER_STATUS -ne 0 -o $WORKER_STATUS -ne 0 ]; then
    echo "One of the processes has already exited.";
    exit 1;
  fi;
done;