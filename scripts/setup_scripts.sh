server_ip_address="10.1.9.84" #ip address of the machine where JAZ service service exists
agent_type="Linux" # Win / Linux (target agent)
database_type="psql" # psql / mysql

sed -i '/server_ip_address/d' /etc/environment
sed -i '/agent_type/d' /etc/environment
sed -i '/database_type/d' /etc/environment

rm -rf /tmp/jaz_testing/
rm -rf /usr/local/bin/db_execute
rm -rf /usr/local/bin/jobnetctl
rm -rf /usr/local/bin/testresult
rm -rf /usr/local/bin/jaz_conf_update

mkdir -p /tmp/jaz_testing/testing_result

echo "server_ip_address="$server_ip_address"" | sudo tee -a /etc/environment > /dev/null 2>&1
echo "agent_type="$agent_type"" | sudo tee -a /etc/environment > /dev/null 2>&1
echo "database_type="$database_type"" | sudo tee -a /etc/environment > /dev/null 2>&1

cp -f querys.txt /tmp/jaz_testing/

chmod +x ../scripts/*

cp -f db_execute.sh /usr/local/bin/db_execute
cp -f jobnetctl.sh /usr/local/bin/jobnetctl
cp -f testresult.sh /usr/local/bin/testresult
cp -f jaz_conf_update.sh /usr/local/bin/jaz_conf_update

chmod +x ../Testcase/*
cd /usr/local/bin/
chmod +x db_execute jobnetctl testresult

if [ "$1" == "check" ]; then
    jobnetctl enable ${agent_type}_Jobnet "job_icon" hostname
    result=$(echo $?)
    if [ "$result" != "0" ]; then
        echo "Something went wrong with DB execution. \n
        Please check your 'database_type' parameters."
        exit 1
    fi
    jobnet_id=$(jobnetctl run ${agent_type}_Jobnet)
    result=$(echo $?)
    if [ "$result" != "0" ]; then
        echo "Something went wrong with job execution. \n
        Please check your 'server_ip_address' parameters."
        exit 1
    fi
    if [ "$jobnet_id" == "" ]; then
        echo "Something went wrong with job execution. \n
        Please importJAZ_automation.xml."
        exit 1
    fi
    sleep 10
    jobnet_status=$(jobnetctl jobnet_status $jobnet_id)
    if [ "$jobnet_status" != "3" ]; then
        echo "
        Something went wrong with job execution. \n
        Please check your 'agent_type' parameters. \n
        (or)\n
        Please check your hostname configuration in zabbix
        "
        exit 1
    fi
fi