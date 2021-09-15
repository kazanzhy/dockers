#!/usr/bin/env bash
export PATH="$(pg_config --bindir):$PATH";
su -p postgres -c "pg_ctl start";
redis-server --daemonize yes;
gunicorn -c $SUPERSET_HOME/gunicorn_config.py $FLASK_APP;