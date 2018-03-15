#! /bin/bash

set -ex

cluster="${1}"
master="${2}"
shift 2
slave_hosts="${@}"

# Setup replication on the slaves
for slave in ${slave_hosts}; do
  (
    echo "SET SQL_LOG_BIN = 0;"
    echo "CHANGE MASTER '${cluster}' TO master_host = '${master}', master_user = 'replicator', master_password = 'replicator', master_use_gtid = CURRENT_POS, master_heartbeat_period = 0.1;"
    echo "START SLAVE '${cluster}';"
  ) | mysql -vvv -h "${slave}" -u root mysql
  shift
done

# Prepare replication settings on master, but do not start.
(
  echo "SET SQL_LOG_BIN = 0;"
  echo "CHANGE MASTER '${cluster}' TO master_user = 'replicator', master_password = 'replicator', master_use_gtid = CURRENT_POS, master_heartbeat_period = 0.1;"
) | mysql -vvv -h "${master}" -u root mysql
