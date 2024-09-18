source /etc/environment
jobnetctl enable ${agent_type}_Jobnet_char_count "job_icon" "24"
jobnet_id=$(jobnetctl run ${agent_type}_Jobnet_char_count)
sleep 10

query=$(grep "jobnet_stdout" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
query=$(echo "$query" | sed "s/\$jobnet_id/'$jobnet_id'/")
echo $query > /tmp/jaz_testing/query.sql
std_out=$(db_execute /tmp/jaz_testing/query.sql select)
std_out=$(echo $std_out | awk -F'---+' '{print $2}' | awk '{print $1}' | tr -d '"')
len=${#std_out}
((len--))
len=$((len + 7))
if [ "$len" == 24 ]; then
  testresult log "testcase3.1.1" "0" $jobnet_id
  exit 0
else
  testresult log "testcase3.1.1" "-1" $jobnet_id
  exit 1
fi
