source /etc/environment
jobnetctl enable JOBNET_1 "job_icon($agent_type)" hostname
jobnet_id=$(jobnetctl run JOBNET_1)
sleep 10 
jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
if [ "$jobnet_status" == "3" ]; then
  testresult log "testcase1.0.0" "0" $jobnet_id
  exit 0
elif [ "$jobnet_status" == "4" ]; then  
  testresult log "testcase1.0.0" "4" $jobnet_id
  exit 4
else
    testresult log "failed_testcase2.0.0" "4" $jobnet_id
    exit 4
fi