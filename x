#!/bin/bash
function str(){
  cat "$1" | sed -e 's/\t/ /g' | sed -e 's/  */ /g'
}

function exists(){
  if command -v "$1" &> /dev/null; then
    echo "true"
  else
    echo "false"
  fi
}

# # script may have a shebang
# function parse_shebang(){
#   if [[ $1 == "#!"* ]]; then
#     first=$(head -n 1 "$1")
#     first=${first:2}
#     first=$(echo "$first" | sed -e 's/ //g')

#     IFS='/' read -ra ADDR <<< "$first"
#     last="${ADDR[-1]}"
#     last=${last:2}
#     last=${last::-1}
#     echo "$last"
#   else
#     echo "$1"
#   fi
# }

# run_c "$1"
function runner(){
  args=("$@")
  args=("${args[@]:1}")

  # stream to compiler
  if [[ $1 == *.c ]]; then
    str "$1" | gcc -w -x c -;
  elif [[ $1 == *.rs ]]; then
    str "$1" | rustc -o tmp -;
  elif [[ $1 == *.f90 ]]; then
    str "$1" | gfortran -ffree-form -x f95 -o tmp -;

  # execute directly
  elif [[ $1 == *.rb ]]; then
    ruby "$1" $args
  elif [[ $1 == *.go ]]; then
    go run "$1" $args
  elif [[ $1 == *.hs ]]; then
    # check if ghc
    has_ghc=$(exists ghc)
    has_stack=$(exists stack)
    # if neither then error
    if [ "$has_ghc" == "false" ] && [ "$has_stack" == "false" ]; then
      echo "ghc or stack not found"
      exit 1
    fi
    # if ghc then use ghc
    if [ "$has_ghc" == "true" ]; then
      ghc "$1" $args
    else
      stack runghc "$1" $args
    fi
  elif [[ $1 == *.js ]]; then
    node "$1" $args
  elif [[ $1 == *.py ]]; then
    python3 "$1" $args
  elif [[ $1 == *.ts ]]; then
    has_bun=$(exists bun)
    has_tsc=$(exists tsc)
    # if neither then error
    if [ "$has_bun" == "false" ] && [ "$has_tsc" == "false" ]; then
      echo "bun or tsc not found"
      exit 1
    fi
    if [ "$has_bun" == "true" ]; then
      bun "$1" $args
    else
      tsc "$1"
      node "${1%.*}.js" $args
    fi
  elif [[ $1 == *.php ]]; then
    php "$1" $args
  else
    echo "not supported, got $1"
    exit 1
  fi

  # execute
  if [ -f tmp ]; then
    ./tmp $args
    rm tmp
  elif [ -f a.out ]; then
    ./a.out $args
    rm a.out
  fi
}

runner "$1" "${@:2}"