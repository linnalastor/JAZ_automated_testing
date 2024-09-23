# JAZ_automated_testing
# Automated testing for Job Arranger for Zabbix

In order to run the testcases, you will need to do the following.
1. This test have to be executed on JAZ server machine(Linux).
2. You must use "win_host_name" for window and "host_name" for Linux as a hostname in zabbix.
3. Change server_ip_address,agent_type and database_type in set_script.sh under script diractory.
4. You might need to update command usage for database according to you machine. 
    # Eg. I use "mysql zabbix" and "sudo -u zabbix -p zabbix psql" for executing query without the need of using password.  
5. Execute the setup_script.sh
6. Import the JAZ_automation.xml
7. To execute all the testcase under 'Testcase' diractory, you need to execute start_testing.sh under 'Testcase' diractory

Log output for executed testcase can be check under [/tmp/jaz_testing/testing_result]

