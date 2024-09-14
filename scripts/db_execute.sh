#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Usage: db_execute <mysql|psql> <query_file>"
  exit 1
fi

option="$1"

case "$option" in
  mysql)
    mysql zabbix < $2 #> /dev/null 2>&1 
    ;;
  psql)
    sudo -u zabbix -p zabbix psql < $2 #> /dev/null 2>&1
    ;;
  *)
    echo "Invalid option. Use 'mysql' or 'psql'."
    exit 1
    ;;
esac