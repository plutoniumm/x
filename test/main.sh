num=$1
# check its a number xx.xx/-xx.xx
if [[ $num =~ ^[+-]?[0-9]+\.?[0-9]*$ ]]; then
  ext=${num##*.}
  echo ${ext:0:2}
else
  echo "Not a number"
fi