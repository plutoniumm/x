# we now run all programs of main.ext in sequence and test
# testing general runner ./x <file> args

# expected=(/* todo */)
actual=()

exts=("c" "rb" "js" "ts" "hs" "rs" "php" "go")
current=15
iter=0
for file in ${exts[@]}; do
  filename="test/main.$file"
  echo "Running $filename with $current"

  current=$(./x $filename $current)
  if [ $? -ne 0 ]; then
    echo "Error: $filename"
    exit 1
  fi

  iter=$((iter+1))
  echo "at $iter: $current"
  actual[$iter]=$current
done

# if lasts are equal then we are good
# if [ "${actual[-1]}" == "${expected[-1]}" ]
#   echo "All tests passed"
# else
#   # check each to see where it failed
#   for i in "${!actual[@]}"; do
#     if [ "${actual[$i]}" != "${expected[$i]}" ]
#       echo "Test $i failed"
#       echo "Expected: ${expected[$i]}"
#       echo "Actual: ${actual[$i]}"
#     fi
#     break
#   done
# fi
