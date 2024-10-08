source /etc/environment
jobnetctl enable ${agent_type}_Jobnet "job_icon" "sleep 1000"
jobnetctl run ${agent_type}_Jobnet > /dev/null 2>&1 

sleep 60

query=$(grep "total_summary_jobnet_count" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
echo $query > /tmp/jaz_testing/query.sql

std_out=$(db_execute /tmp/jaz_testing/query.sql select)

if [ "$std_out" == "1" ]; then
    exit 0
else 
    exit 1
fi