jobnetctl enable JOBNET_1 'job_icon(win_host_name)' hostname
jobnet_id=$(jobnetctl run JOBNET_1)
sleep 10 
jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
if [ "$jobnet_status" == "3" ]; then
    echo -e "\e[32m\ntestcase1 has successfully finished. \nTest Result\e[0m" >> /tmp/jaz_testing/testing_result/testcase1.log
    echo $(jobnetctl jobarg_get $jobnet_id) >> /tmp/jaz_testing/testing_result/testcase1.log
    exit 0
elif [ "$jobnet_status" == "4" ]; then  
    echo -e "\e[31m\ntestcase1 has failed. \nTest Result\e[0m" >> /tmp/jaz_testing/testing_result/testcase1.log
    echo $(jobnetctl jobarg_get $jobnet_id) >> /tmp/jaz_testing/testing_result/testcase1.log
    exit 4
fi