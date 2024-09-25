source /etc/environment
jobnetctl delete_all_jobnet
jobnetctl enable ${agent_type}_Jobnet "job_icon" "sleep 1000"
jobnet_id=$(jobnetctl run ${agent_type}_Jobnet)
sleep 3
jobnetctl abort $jobnet_id

sleep 70

query=$(grep "total_summary_jobnet_count" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
echo $query > /tmp/jaz_testing/query.sql
std_out=$(db_execute /tmp/jaz_testing/query.sql select)

query=$(grep "update_JOBNET_KEEP_SPAN" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
query1="${query/\$value/60}"
echo $query1 > /tmp/jaz_testing/query.sql
db_execute /tmp/jaz_testing/query.sql

query=$(grep "update_JOBLOG_KEEP_SPAN" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
query1="${query/\$value/60}"
echo $query1 > /tmp/jaz_testing/query.sql
db_execute /tmp/jaz_testing/query.sql

systemctl restart jobarg-server
sleep 10
if [ "$std_out" = "0" ]; then
    exit 0
else 
    exit 1
fi