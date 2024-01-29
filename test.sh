# we now run all programs of main.ext in sequence and test
# testing general runner ./x <file> args

expected=("-1" "4" "1" "2" "295.33612" "158" "1.5849625007212" "0.9160792412167597" "52" "103" "1" "-13.643408")
actual=()

# py, f90
exts=("c" "rb" "js" "ts" "hs" "rs" "php" "go" "sc" "lua" "f90" "py")
current=15
iter=0
for file in ${exts[@]}; do
  filename="test/main.$file"
  echo "Running $filename <- $current"

  current=$(./x $filename $current)
  if [ $? -ne 0 ]; then
    echo "Error: $filename"
    exit 1
  fi
  current=$(echo $current | xargs)

  echo "\t =$current"
  actual[$iter]=$current
  if [ "$current" != "${expected[$iter]}" ]; then
    echo "Test $iter failed"
    echo "Expected: ${expected[$iter]}"
    echo "Actual: $current"
    exit 1
  fi
  iter=$((iter+1))
done