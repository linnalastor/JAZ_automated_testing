ip_address="10.1.9.84"
sed -i "s/ip_address/$ip_address/g" jobnetctl.sh

rm -rf /tmp/jaz_testing/
rm -rf /tmp/jaz_testing/testing_result
rm -rf /usr/local/bin/db_execute
rm -rf /usr/local/bin/jobnetctl
rm -rf /usr/local/bin/testresult

mkdir -p /tmp/jaz_testing/testing_result

cp -f querys.txt /tmp/jaz_testing/

cp -f db_execute.sh /usr/local/bin/db_execute
cp -f jobnetctl.sh /usr/local/bin/jobnetctl
cp -f testresult.sh /usr/local/bin/testresult

cd /usr/local/bin/
chmod +x db_execute jobnetctl testresult