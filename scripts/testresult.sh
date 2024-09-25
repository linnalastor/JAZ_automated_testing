if [ "$#" -lt 3 ]; then
  echo "Usage: testresult <print | log> <test_case> <result>"
  exit 1
fi
if [ "$#" -lt 4 ] && [ "$1" == "log" ]; then
  echo "Usage: testresult log <test_case> <result> <jobnet id>"
  exit 1
fi

case "$1" in
    print)
      if [ $3 == "0" ]; then  
          echo -e "$2 \e[32mSucceed\e[0m"
      else
          echo -e "$2 \e[31mFailed\e[0m"
      fi
    ;;
    log)
      if [ $3 == "0" ]; then
        result="\e[32m$2.sh has successfully finished.\e[0m "
      else
        result="\e[31m$2.sh has Failed.\e[0m "
      fi
      logfile="/tmp/jaz_testing/testing_result/$2.log"
      echo -e "$result\nTest Result" >> "$logfile"
      echo $(jobnetctl jobarg_get $4) >> "$logfile"
    ;;
  *)
    echo "Invalid option. Use <print | log>."
    exit 1
    ;;
esac


