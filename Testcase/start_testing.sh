TARGET_DIR=$(pwd)
subdirs=$(find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -type d)

for dir in $subdirs; do
 scripts=$(find "$dir" -type f -name "*.sh")
 for script in $scripts; do
  bash "$script"
  return_code=$?
  testresult print $script $return_code
 done
done
