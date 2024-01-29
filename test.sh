# we now run all programs of main.ext in sequence and test
# testing general runner ./x <file> args
expected=("-1" "4" "1" "2" "295.33612" "158" "1.5849625007212" "0.9160792412167597" "52" "103" "1" "-13.643408" "1.618034")

# py, f90
exts=("c" "rb" "js" "ts" "hs" "rs" "php" "go" "sc" "lua" "f90" "py" "ml")
current=15
iter=0
for file in ${exts[@]}; do
  filename="test/main.$file"
  echo "$file <- $current"

  # suppress all errors & warnings
  current=$(./x $filename $current 2> /dev/null)
  if [ $? -ne 0 ]; then
    echo "Error: $filename"
    exit 1
  fi
  current=$(echo $current | xargs)

  if [ "$current" != "${expected[$iter]}" ]; then
    echo "$file failed with $filename"
    echo "Expect: ${expected[$iter]}"
    echo "Actual: $current"
    exit 1
  fi
  iter=$((iter+1))
done

# all tests passed in green
echo "\033[32m All tests passed \033[0m"