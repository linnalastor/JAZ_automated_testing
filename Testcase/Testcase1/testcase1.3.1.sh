source /etc/environment

if [ "$agent_type" == "Win" ]; then 
  jobnetctl enable "Window_Agent" "service_control" "restart 120"
  jobnet_id=$(jobnetctl run "Window_Agent")
  sleep 140
elif [ "$agent_type" == "Linux" ]; then 
  jobnetctl enable ${agent_type}_Jobnet "job_icon" "sleep 1000"
  jobnet_id=$(jobnetctl run ${agent_type}_Jobnet) 
  systemctl stop jobarg-agentd
  sleep 60
  systemctl start jobarg-agentd
  sleep 10
fi

jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
if [ "$jobnet_status" == "2" ]; then
  testresult log "testcase1.0.0" "0" $jobnet_id
  jobnetctl delete_all_jobnet
  exit 0
else
    testresult log "failed_testcase2.0.0" "1" $jobnet_id
    exit 1
fi