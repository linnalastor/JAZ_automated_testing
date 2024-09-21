sleep 60
query=$(grep "update_JOBNET_KEEP_SPAN" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
query1="${query/\$value/1}"
echo $query1 > /tmp/jaz_testing/query.sql
db_execute /tmp/jaz_testing/query.sql

systemctl restart jobarg-server
sleep 5

query=$(grep "total_summary_jobnet_count" /tmp/jaz_testing/querys.txt | awk -F": " '{print $2}')
echo $query > /tmp/jaz_testing/query.sql

std_out=$(db_execute /tmp/jaz_testing/query.sql select)

if [ "$std_out" == "0" ]; then
    exit 0
else 
    exit 1
fi


