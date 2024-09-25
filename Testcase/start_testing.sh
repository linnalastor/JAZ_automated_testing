TARGET_DIR=$(pwd)
subdirs=$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d)
count=0
passed=0
for dir in $subdirs; do
  scripts=$(find "$dir" -type f -name "*.sh")
  for script in $scripts; do
    file_name=$(basename "$script")
    current_time=$(date +"%H:%M:%S")
    echo "$current_time $file_name execution will start now"
    bash "$script"
    return_code=$?
    testresult print $file_name $return_code
    $defunct=$(ps -aux | grep defunct | wc -l)
    if [ "$defunct" > "1" ]; then
      sleep 10
      $defunct=$(ps -aux | grep defunct | wc -l)
      if [ "$defunct" > "1" ]; then
        echo -e "\e[31m $defunct defunct process found. \e[0m "
      fi
    fi

    ((count++))
    if [ "$return_code" == "0" ]; then
      ((passed++))
      echo $script >> /tmp/jaz_testing/testing_result/succeed_testcase.log
    else
      echo $script >> /tmp/jaz_testing/testing_result/failed_testcase.log
    fi
  done
done

if [ "$count" -gt 0 ]; then
    passed_percentage=$(( (passed * 100) / count ))
else
    passed_percentage=0
fi

echo -e "\e[32m\nAutomated testing has finished. Count: $count\e[0m "
echo -e "\e[32mPassed Testcase : $passed_percentage%\e[0m "
if [ "$passed_percentage" -lt 100 ]; then
echo -e "\e[31mCheck failed testcase in [/tmp/jaz_testing/testing_result/failed_testcase.log]\e[0m "
fi
