if [ "$#" -lt 3 ]; then
  echo "Usage: jaz_conf_update <server | agent> <parameter> <parameter=value>"
  exit 1
fi


source /etc/environment
case "$1" in
  server)
    tac /etc/jobarranger/jobarg_server.conf | sed "0,/$2/s/.*$2.*/$3/" | tac | sudo tee temp > /dev/null && sudo mv temp /etc/jobarranger/jobarg_server.conf
  ;;
  agent)
    tac /etc/jobarranger/jobarg_agentd.conf | sed "0,/$2/s/.*$2.*/$3/" | tac | sudo tee temp > /dev/null && sudo mv temp /etc/jobarranger/jobarg_agentd.conf
    ;;
  *)
    echo "Invalid option. Use < server | agent >."
    exit 1
    ;;
esac