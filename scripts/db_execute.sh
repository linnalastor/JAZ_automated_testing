#!/bin/bash

if [ "$#" -lt 1 ]; then
  echo "Usage: db_execute <query_file>"
  exit 1
fi
source /etc/environment
option="$database_type"

case "$option" in
  mysql)
    if [ "$2" == "" ]; then
      mysql zabbix < $1 # [mysql zabbix < script] is use to execute sql file in mysql database
    else
      mysql zabbix < $1 > /dev/null 2>&1 # [mysql zabbix < script] is use to execute sql file in mysql database
    fi
    ;;
  psql)
    if [ "$2" == "select" ]; then
      # [sudo -u zabbix -p zabbix psql < script] is use to execute sql file in psql database
      sudo -u zabbix -p zabbix psql -t -A -f $1 
    else
      # [sudo -u zabbix -p zabbix psql < script] is use to execute sql file in psql database
      sudo -u zabbix -p zabbix psql -t -A -f $1  > /dev/null 2>&1 
    fi
    ;;
  *)
    echo "Invalid option. Use 'mysql' or 'psql'."
    exit 1
    ;;
esac