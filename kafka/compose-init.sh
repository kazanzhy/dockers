#!/usr/bin/env bash
airflow db init;
airflow users create -u admin -p admin -f Airflow -l Admin -r Admin -e admin@fab.org;
airflow db upgrade;