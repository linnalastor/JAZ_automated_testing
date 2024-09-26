source /etc/environment
jobnetctl enable ${agent_type}_Jobnet "job_icon" hostname
jobnet_id=$(jobnetctl run ${agent_type}_Jobnet)
sleep 10 
jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
if [ "$jobnet_status" == "3" ]; then
  testresult log "testcase1.0.0" "0" $jobnet_id
  exit 0
elif [ "$jobnet_status" == "4" ]; then  
  testresult log "testcase1.1.1" "4" $jobnet_id
  exit 4
else
    testresult log "failed_testcase1.1.1" "4" $jobnet_id
    exit 4
fi