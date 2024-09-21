check=$(cat /var/log/jobarranger/jobarg_server.log | grep "jobnet boot")
if [ "$check" != "" ]; then
    exit 0
else 
    exit 1
fi