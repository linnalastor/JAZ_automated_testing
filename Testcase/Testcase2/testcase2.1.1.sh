source /etc/environment
jobnetctl enable ${agent_type}_Jobnet "fcopy_icon" "file creation included"
jobnet_id=$(jobnetctl run ${agent_type}_Jobnet)
jobnetctl enable ${agent_type}_Jobnet "fwait_icon(wait)" "C_User_testinng_test.txt"
jobnet_id2=$(jobnetctl run ${agent_type}_Jobnet)
sleep 10 
jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
jobnet2_status=$(jobnetctl jobnet_status $jobnet_id2)
if [ "$jobnet_status" == "3" ]; then
  if [ "$jobnet2_status" == "2" ]; then
    testresult log "fail_testcase2.0.0" "2" $jobnet_id
    exit 1
  fi
  testresult log "testcase2.0.0" "0" $jobnet_id
  exit 0
elif [ "$jobnet_status" == "4" ]; then  
    testresult log "failed_testcase2.0.0" "4" $jobnet_id
    exit 4
else 
    testresult log "failed_testcase2.0.0" "4" $jobnet_id
    exit 4
fi

