#!/usr/bin/env bash
redis-server --daemonize yes;
gunicorn -c $SUPERSET_HOME/gunicorn_config.py $FLASK_APP;