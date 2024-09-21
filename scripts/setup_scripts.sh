server_ip_address="10.1.9.84" #ip address of the machine where JAZ service service exists
agent_type="Win" # Win / Linux (target agent)
database_type="psql" # psql / mysql

sed -i '/server_ip_address/d' /etc/environment
sed -i '/agent_type/d' /etc/environment
sed -i '/database_type/d' /etc/environment

rm -rf /tmp/jaz_testing/
rm -rf /usr/local/bin/db_execute
rm -rf /usr/local/bin/jobnetctl
rm -rf /usr/local/bin/testresult

mkdir -p /tmp/jaz_testing/testing_result

echo "server_ip_address="$server_ip_address"" | sudo tee -a /etc/environment > /dev/null 2>&1
echo "agent_type="$agent_type"" | sudo tee -a /etc/environment > /dev/null 2>&1
echo "database_type="$database_type"" | sudo tee -a /etc/environment > /dev/null 2>&1

cp -f querys.txt /tmp/jaz_testing/

cp -f db_execute.sh /usr/local/bin/db_execute
cp -f jobnetctl.sh /usr/local/bin/jobnetctl
cp -f testresult.sh /usr/local/bin/testresult

chmod +x ../Testcase/*
cd /usr/local/bin/
chmod +x db_execute jobnetctl testresult