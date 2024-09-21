systemctl stop jobarg-server
sleep 1
> /var/log/jobarranger/jobarg_server.log
systemctl start jobarg-server
sleep 1
check=$(cat /var/log/jobarranger/jobarg_server.log | grep "purge old jobnet")
if [ "$check" != "" ]; then
    exit 0
else 
    exit 1
fi