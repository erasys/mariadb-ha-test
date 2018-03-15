#! /bin/bash

set -ex

server="${1}"

(
  echo "SET SQL_LOG_BIN = 0;"
  cat /setup/grants.sql
  echo "RESET MASTER;"
) | mysql -vvv -h "${server}" -u root mysql
