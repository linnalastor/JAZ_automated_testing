1. Enable jobnet 
    jobnetctl enable <jobnet id> <jobnet name> <description>
    ### Enable a specific jobnet version

    jobnetctl enable_default <jobnet id>
    ### Enable jobnet version with the latest updated date

2. Disable jobnet 
    jobnetctl disable <jobnet id>

3. Run jobnet
    jobnetctl run <jobnet id>

4. Abort jobnet (force stop jobnet)
    jobnetctl abort <jobnet id>

5. Execute query
    ### add the query into the script/querys.txt [ query_id : query ]

    db_execute <mysql | psql> <query_file>
    ### you have to create your own query file. Default path is [/tmp/jaz_testing/query.sql]

    ###If you want the execution of query to output execution result add an extra option
    examplle : db_execute <mysql | psql> <query_file> select

6. Output Test result
    testresult print <test_case> <result>
    testresult log <test_case> <result> <jobnet id>

    ### Testcase successfull ==> result = "0"
    ### Testcase fail ==> result = "anything"

    ### Testcase log will be written to [/tmp/jaz_testing/testing_result/]


     