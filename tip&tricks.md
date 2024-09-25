# Jobnet Cotrol
- Enable a specific jobnet version: 
    - jobnetctl enable <jobnet id> <jobnet name> <description>

- Enable jobnet version with the latest updated date: 
    - jobnetctl enable_default <jobnet id>
    
- Disable jobnet: 
    - jobnetctl disable <jobnet id>

- Run jobnet: 
    - jobnetctl run <jobnet id>

- Abort jobnet (force stop jobnet): 
    - jobnetctl abort <jobnet id>

- Get jobnet's basic information: 
    - jobnetctl jobarg_get <jobnet id>

- Get jobnet's status: 
    - jobnetctl jobnet_status <jobnet id>

- Delete all jobnet information on server side: 
    - jobnetctl delete_all_jobnet <jobnet id>

# Execute query
    - adding the query into the script/querys.txt in recommanded. Format [ query_id : query ]
    - setup the query and create sql file. Default path is [/tmp/jaz_testing/query.sql]

    db_execute <query_file>
    
    ***If you want the execution of query to output execution result, add an extra option.
    example : db_execute <query_file> select

# Output Test result
    testresult print <test_case> <result>
    testresult log <test_case> <result> <jobnet id>

    * Testcase successfull ==> result = "0"
    * Testcase fail ==> result = "anything"

    * Testcase log will be written to [/tmp/jaz_testing/testing_result/]

# Update JAZ config parameters
- Update parameter in jobarg_server.config: 
    - jaz_conf_update server <parameter> <parameter value>

- Update parameter in jobarg_agentd.config: 
    - jaz_conf_update server <parameter> <parameter value>


     