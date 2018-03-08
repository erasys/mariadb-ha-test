#! /bin/sh

if [ -z "$3" ]; then
  echo "Usage: $0 <port> <db> <table> <sleep>"
  echo
  echo "Repeatedly inserts a record into given table."
  echo "The table can consist of arbitrary colums, but all of them require a"
  echo "proper default value, and there must be a primary key column 'id'."
  exit 1
fi

while true; do
  mysql --defaults-extra-file=./client.cnf --port=$1 -e "INSERT INTO $3 (id) VALUES (null);" $2
  sleep ${4:-1}
done
