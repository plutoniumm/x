# we now run all programs of main.ext in sequence and test
# testing general runner ./x <file> args

# expected=(/* todo */)
actual=()

exts=("c" "f90" "go" "js" "py" "rs" "ts")
current=0
iter=0
for file in ${exts[@]}; do
  filename="test/main.$file"
  current=$(./x $filename $current)
  iter=$((iter+1))
  actual[$iter]=$current
  echo "Test $current: $filename"
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
