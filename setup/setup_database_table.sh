#! /bin/bash

set -ex


server="${1}"
database="${2}"
table="${3}"

(
  echo "CREATE DATABASE ${database};"
  echo "USE ${database};"
  echo "CREATE TABLE ${table} (id int unsigned auto_increment PRIMARY KEY, createdAt timestamp);"
) | mysql -vvv -h "${server}" -u root mysql
