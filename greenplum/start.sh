#!/bin/bash
set -m;
source /opt/greenplum-db-*/greenplum_path.sh;

# Start OpenSSH (as root) and exchange keys
echo "127.0.0.1	$(hostname) $(hostname).localdomain" | sudo tee -a /etc/hosts;
sudo ssh-keygen -f /etc/ssh/id_rsa -N '';
sudo /etc/init.d/ssh start;
gpssh-exkeys -h $(hostname);

# Setup Greenplum
hostname > ./hostlist_singlenode;
echo "ARRAY_NAME=\"Greenplum Data Platform\"
SEG_PREFIX=gpseg
PORT_BASE=6000
declare -a DATA_DIRECTORY=(/home/gpadmin/gpdata /home/gpadmin/gpdata)
MASTER_DIRECTORY=/home/gpadmin/master
MASTER_HOSTNAME=$(hostname)
MASTER_PORT=54321
MASTER_MAX_CONNECT=250
TRUSTED_SHELL=ssh
CHECK_POINT_SEGMENTS=8
ENCODING=UNICODE
DATABASE_NAME=gpadmin" > ./gpinitsystem_singlenode;

## Start Greenplum
gpinitsystem -a -c gpinitsystem_singlenode -h hostlist_singlenode -e gpadmin --ignore-warnings;
echo "host    all   all   0.0.0.0/0   md5" >> master/gpseg-1/pg_hba.conf;
gpstop -u; # Reload configs
sleep infinity;