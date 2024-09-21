source /etc/environment

if [ "$agent_type" == "Win" ]; then 
  jobnetctl enable "Window_Agent" "service_control" "restart 120"
  jobnet_id=$(jobnetctl run "Window_Agent")
fi
sleep 140

jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
if [ "$jobnet_status" == "3" ]; then
  testresult log "testcase1.0.0" "0" $jobnet_id
  jobnetctl delete_all_jobnet
  exit 0
else
    testresult log "failed_testcase2.0.0" "1" $jobnet_id
    exit 1
fi