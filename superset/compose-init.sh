#!/usr/bin/env bash
sleep 5;
superset db upgrade;
superset fab create-admin --username admin --password admin --firstname Superset --lastname Admin --email admin@fab.org;
superset init;