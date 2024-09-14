#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo "Usage: db_execute <mysql | psql> <query_file>"
  exit 1
fi

option="$1"

case "$option" in
  mysql)
    if [ "$3" == "" ]; then
      mysql zabbix < $2
    else
      mysql zabbix < $2 > /dev/null 2>&1 
    fi
    ;;
  psql)
    if [ "$3" == "select" ]; then
      sudo -u zabbix -p zabbix psql < $2
    else
      sudo -u zabbix -p zabbix psql < $2 > /dev/null 2>&1 
    fi
    ;;
  *)
    echo "Invalid option. Use 'mysql' or 'psql'."
    exit 1
    ;;
esac