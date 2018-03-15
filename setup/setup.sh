#! /bin/bash

set -ex


cluster="${1}"
database="${2%.*}"
table="${2#*.}"
master="${3}"
shift 3
slaves="${@}"


for i in ${master} ${slaves}; do
  $(dirname $0)/setup_grants.sh ${i}
done

$(dirname $0)/setup_master_slave_replication.sh ${cluster} ${master} ${slaves}
$(dirname $0)/setup_database_table.sh ${master} ${database} ${table}

exit 0
