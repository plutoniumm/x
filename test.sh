# we now run all programs of main.ext in sequence and test
# testing general runner ./x <file> args
expected=("-1" "4" "1" "2" "295.33612" "158" "1.5849625007212" "0.9160792412167597" "52" "103" "1" "-13.6434*" "1.618034" "55" "3.14*" "0.098*" "5" "0.8346" "39.85" "6.31" "6.6947" "69" "0.6620042" "0" "40.00" "-74")

# py, f90
exts=("c" "rb" "js" "ts" "hs" "rs" "php" "go" "sc" "lua" "f90" "py" "ml" "kt" "cpp" "exs" "swift" "java" "jl" "cob" "scpt" "sh" "r" "m" "dart" "zig")
current="15"
iter=0
for file in ${exts[@]}; do
  filename="test/main.$file"
  echo "$file $current ->"

  # suppress all errors & warnings
  current=$(./x $filename $current)
  if [ $? -ne 0 ]; then
    echo "Error: $filename"
    exit 1
  fi
  current=$(echo $current | xargs)

  # if expected has a * it's gonna be a regex match
  if [[ ${expected[$iter]} == *"*"* ]]; then
    if [[ ! $current =~ ${expected[$iter]} ]]; then
      echo "$file failed with $filename"
      echo "Expect: ${expected[$iter]}"
      echo "Actual: $current"
      exit 1
    fi
  else
    if [ "$current" != "${expected[$iter]}" ]; then
      echo "$file failed with $filename"
      echo "Expect: ${expected[$iter]}"
      echo "Actual: $current"
      exit 1
    fi
  fi
  iter=$((iter+1))
done

echo "\033[32m Compile tests passed \033[0m"

# converage
implemented=($(grep "==\ \*" ./x | grep if | awk '{print $5}' | sed 's/\*\.//'))
# check if all implemented are in exts
for ext in ${exts[@]}; do
  if [[ ! " ${implemented[@]} " =~ " $ext " ]]; then
    echo "Not implemented: $ext"
    exit 1
  fi
done

implemented=(${implemented[@]/applescript/})
for ext in ${implemented[@]}; do
  if [[ ! " ${exts[@]} " =~ " $ext " ]]; then
    echo "Not in exts: $ext"
    exit 1
  fi
done

echo "\033[32m Coverage tests passed \033[0m"