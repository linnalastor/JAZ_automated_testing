query=$(grep "update_JOBLOG_KEEP_SPAN" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
query1="${query/\$value/1}"
echo $query1 > /tmp/jaz_testing/query.sql
db_execute /tmp/jaz_testing/query.sql

systemctl restart jobarg-server
sleep 5

query2=$(grep "total_jobnet_log_count" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
echo $query2 > /tmp/jaz_testing/query.sql

std_out=$(db_execute /tmp/jaz_testing/query.sql select)
std_out=$(echo $std_out | awk -F'---+' '{print $2}' | awk '{print $1}' | tr -d '"')

if [ "$std_out" == "0" ]; then
    exit 0
else 
    exit 1
fi
