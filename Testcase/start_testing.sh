succeed="\e[32mSucceed\e[0m"
failed="\e[31mFailed\e[0m"

./testcase1.sh
return_code=$?
testresult testcase1 $return_code
