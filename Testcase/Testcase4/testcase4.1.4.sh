source /etc/environment
jobnetctl enable ${agent_type}_Jobnet_char_count "job_icon" "136"
jobnet_id=$(jobnetctl run ${agent_type}_Jobnet_char_count)
sleep 10

query=$(grep "jobnet_stdout" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
echo $query > /tmp/jaz_testing/query.sql
std_out=$(db_execute /tmp/jaz_testing/query.sql select)
len=${#std_out}
len=$((len + 5))
if [ "$len" == 136 ]; then
  testresult log "testcase3.1.4" "0" $jobnet_id
  exit 0
else
  testresult log "testcase3.1.4" "-1" $jobnet_id
  exit 1
fi
