if [ "$#" -lt 2 ]; then
  echo "Usage: testresult <test_case> <result>"
  exit 1
fi
if [ $2 == "0" ]; then  
    echo -e "$1 \e[32mSucceed\e[0m"
else
    echo -e "$1 \e[31mFailed\e[0m"
fi