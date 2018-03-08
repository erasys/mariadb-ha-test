#! /bin/bash

set -ex

function setupGrants() {
  server="mariadb_${1}"

  (
    echo "SET SQL_LOG_BIN = 0;"
    cat /setup/grants.sql
    echo "RESET MASTER;"
  ) | mysql -vvv -h "${server}" -u root mysql
}


function setupReplication() {
  cluster="${1}"
  master="mariadb_${2}"
  shift 2
  slave_ids="$@"

  # Setup replication on the slaves
  for slave_id in ${slave_ids}; do
    slave="mariadb_${slave_id}"
    (
      echo "SET SQL_LOG_BIN = 0;"
      echo "CHANGE MASTER '${cluster}' TO master_host = '${master}', master_user = 'replicator', master_password = 'replicator', master_use_gtid = CURRENT_POS, master_heartbeat_period = 0.1;"
      echo "START SLAVE '${cluster}';"
    ) | mysql -vvv -h "${slave}" -u root mysql
    shift
  done

  # Setup replication on the warehouse
  slave="mariadb_wh"
  (
    echo "SET SQL_LOG_BIN = 0;"
    echo "CHANGE MASTER '${cluster}' TO master_host = '${master}', master_user = 'replicator', master_password = 'replicator', master_use_gtid = CURRENT_POS, master_heartbeat_period = 0.1;"
    echo "START SLAVE '${cluster}';"
  ) | mysql -vvv -h "${slave}" -u root mysql

  # Prepare replication settings on master, but do not start.
  (
    echo "SET SQL_LOG_BIN = 0;"
    echo "CHANGE MASTER '${cluster}' TO master_user = 'replicator', master_password = 'replicator', master_use_gtid = CURRENT_POS, master_heartbeat_period = 0.1;"
  ) | mysql -vvv -h "${master}" -u root mysql
}


function setupTable() {
  server="mariadb_${1}"
  database="${2}"
  table="${3}"

  (
    echo "CREATE DATABASE ${database};"
    echo "USE ${database};"
    echo "CREATE TABLE ${table} (id int unsigned auto_increment PRIMARY KEY, createdAt timestamp);"
  ) | mysql -vvv -h "${server}" -u root mysql
}


for i in a1 a2 a3 a4 b1 b2 b3 b4 wh; do
  setupGrants "${i}"
done

setupReplication cluster_a a1 a2 a3 a4
setupReplication cluster_b b1 b2 b3 b4

setupTable a1 foo bar
setupTable a2 bla blub

exit 0
