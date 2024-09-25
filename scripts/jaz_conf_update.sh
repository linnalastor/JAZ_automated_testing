if [ "$#" -lt 3 ]; then
  echo "Usage: jaz_conf_update <server | agent> <parameter> <parameter value>"
  echo "This usage is for updating config parameters.\n
  1. use server as first option to update JAZ server config.
  2. use agent as first option to update JAZ agent config.
  3. second option is for config parameter name you want to update
  4. third option is for config parameter value you want to update
  5. use default as third option for dafault parameter value
  "
  exit 1
fi

source /etc/environment
case "$1" in
  server)
    if [ "$(grep -m 1 $2 /etc/jobarranger/jobarg_server.conf)" == "" ]; then
      echo "Invalid parameter! Could not find '$2' in jobarg_server.conf ."
      exit 1
    fi

    if [ "$3" == "default" ]; then
      tac /etc/jobarranger/jobarg_server.conf | sed "0,/$2/s/.*$2.*/# $2=/" | tac | sudo tee temp > /dev/null && sudo mv temp /etc/jobarranger/jobarg_server.conf
    else
      tac /etc/jobarranger/jobarg_server.conf | sed "0,/$2/s/.*$2.*/$2=$3/" | tac | sudo tee temp > /dev/null && sudo mv temp /etc/jobarranger/jobarg_server.conf
    fi
  ;;
  agent)
    if [ "$(grep -m 1 $2 /etc/jobarranger/jobarg_agentd.conf)" == "" ]; then
      echo "Invalid parameter! Could not find '$2' in jobarg_agentd.conf ."
      exit 1
    fi

    if [ "$3" == "default" ]; then
      tac /etc/jobarranger/jobarg_agentd.conf | sed "0,/$2/s/.*$2.*/# $2=/" | tac | sudo tee temp > /dev/null && sudo mv temp /etc/jobarranger/jobarg_agentd.conf
    else
      tac /etc/jobarranger/jobarg_agentd.conf | sed "0,/$2/s/.*$2.*/$2=$3/" | tac | sudo tee temp > /dev/null && sudo mv temp /etc/jobarranger/jobarg_agentd.conf
    fi
  ;;
  *)
    echo "Invalid option. Use < server | agent >."
    exit 1
    ;;
esac