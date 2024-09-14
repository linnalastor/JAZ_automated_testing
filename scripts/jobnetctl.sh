#!/bin/bash
if [ "$#" -lt 1 ]; then
  echo "Usage: jobnetctl <run | enable_default | enable | disable | abort>"
  echo "This usage is for manipulating jobnet such as\n
  1. jobnetctl run <jobnet id>                                  ===> Running Jobnet\n
  2. jobnetctl enable_default <jobnet id>                       ===> Enable jobnet version with the latest updated date\n
  3. jobnetctl enable <jobnet id> <jobnet name> <description>   ===> Enable a specific jobnet version\n
  4. jobnetctl disable <jobnet id>                              ===> Disable the jobnet object
  5. jobnetctl abort <jobnet id>                                ===> force stop the jobnet
  "
  echo "Usage: jobnetctl <jobarg_get | jobnet_status>"
  echo "This usage is for get information such as\n
  1. jobnetctl jobarg_get <jobnet id>       ===> jobnet's basic information 
  2. jobnetctl jobnet_status <jobnet id>    ===> jobnet's status  
  "
  exit 1
fi
option="$1"
if [ "$#" -lt 2 ]; then
  echo "Usage: jobnetctl $option <jobnet_id>"
  exit 1
fi
jobnet_id=$2
if [ "$option" == "enable" ] && [ "$#" -ne 4 ]; then
  if [ "$#" -lt 3 ]; then
    echo "Usage: jobnetctl enable $jobnet_id <sub-jobnet's name> <sub-jobnet's description>"
    exit 1
  elif [ "$#" -lt 4 ]; then
    echo "Usage: jobnetctl enable $jobnet_id $3 <sub-jobnet's description>"
    exit 1
  fi
fi
source /etc/environment
case "$option" in
    run)
        jobarg_exec -z $server_ip_address -U Admin -P zabbix -j $jobnet_id &> /tmp/jaz_testing/output.txt
        registry_number=$(cat /tmp/jaz_testing/output.txt | grep -oP '(?<=Registry number :  \[)\d+(?=\])')
        echo $registry_number
    ;;
    enable_default)
        /usr/local/bin/jobnetctl "disable" "$jobnet_id"
        query=$(grep "enable_default_jobnet" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
        query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
        query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
        echo $query > /tmp/jaz_testing/query.sql
        db_execute psql /tmp/jaz_testing/query.sql
    ;;
    enable)
        jobnet_name=$3
        description=$4
        /usr/local/bin/jobnetctl "disable" "$jobnet_id"
        query=$(grep "enable_jobnet " /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
        query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
        query=$(echo "$query" | sed "s/\$jobnet_name/'$jobnet_name'/")
        query=$(echo "$query" | sed "s/\$memo/'$description'/")
        echo $query > /tmp/jaz_testing/query.sql
        db_execute psql /tmp/jaz_testing/query.sql
    ;;
    disable)
        query=$(grep "disable_jobnet" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
        query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
        echo $query > /tmp/jaz_testing/query.sql
        db_execute psql /tmp/jaz_testing/query.sql
    ;;
    abort)
        query=$(grep "abort_jobnet" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
        query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
        echo $query > /tmp/jaz_testing/query.sql
        db_execute psql /tmp/jaz_testing/query.sql
    ;;
    jobnet_status)
        query=$(grep "jobnet_status" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
        query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
        echo $query > /tmp/jaz_testing/query.sql
        echo $(db_execute psql /tmp/jaz_testing/query.sql select | grep -Eo '^[[:space:]]*[0-9]+' | head -n 1)
    ;;
    jobarg_get)
      jobarg_get -z $server_ip_address -U Admin -P zabbix -r $jobnet_id &> /tmp/jaz_testing/output.txt
      echo "$(cat /tmp/jaz_testing/output.txt)"
    ;;
  *)
    echo "Invalid option. Use < run | enable | disable | abort >."
    exit 1
    ;;
esac