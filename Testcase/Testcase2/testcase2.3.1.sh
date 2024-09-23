source /etc/environment

if [ "$agent_type" == "Win" ]; then 
  jobnetctl enable "Window_Agent" "service_control" "restart 240"
  jobnetctl run "Window_Agent"
  sleep 10
elif [ "$agent_type" == "Linux" ]; then 
  systemctl stop jobarg-agentd
  sleep 10
fi

jobnetctl enable ${agent_type}_Jobnet "fcopy_icon" "test.txt"
jobnet_id=$(jobnetctl run ${agent_type}_Jobnet)

if [ "$agent_type" == "Win" ]; then
  sleep 230
elif [ "$agent_type" == "Linux" ]; then 
  sleep 150
  systemctl start jobarg-agentd
fi
sleep 10
jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
jobnetctl delete_all_jobnet
if [ "$jobnet_status" == "4" ]; then
  testresult log "testcase2.0.0" "0" $jobnet_id
  exit 0
else 
    testresult log "failed_testcase2.0.0" "1" $jobnet_id
    exit 4
fi

