#!/usr/bin/env bash
set -m;

# Start Postgres
export PATH="$(pg_config --bindir):$PATH";
su -p postgres -c "pg_ctl start";

# Run Webserver in background
airflow webserver -D &
WEBSERVER_STATUS=$?; PID=$!;
echo "$(date) - Airflow Webserver: status=$WEBSERVER_STATUS, pid=$PID";

# Run Scheduler in background
airflow scheduler -D &
SCHEDULER_STATUS=$?; PID=$!;
echo "$(date) - Airflow Scheduler: status=$SCHEDULER_STATUS, pid=$PID";

# Check startup
if [ $WEBSERVER_STATUS -ne 0 -o $SCHEDULER_STATUS -ne 0 ]; then
  echo "One of the processes hasn't start.";
  exit 1;
fi;

# Continuous monitoring
while sleep 60; do
  ps aux | grep "airflow-webserver" | grep -q -v "grep";
  WEBSERVER_STATUS=$?;
  echo "$(date) - Airflow Webserver: status=$WEBSERVER_STATUS";

  ps aux | grep "airflow scheduler" | grep -q -v "grep";
  SCHEDULER_STATUS=$?;
  echo "$(date) - Airflow Scheduler: status=$SCHEDULER_STATUS";

  if [ $WEBSERVER_STATUS -ne 0 -o $SCHEDULER_STATUS -ne 0 ]; then
    echo "One of the processes has already exited.";
    exit 1;
  fi;
done;