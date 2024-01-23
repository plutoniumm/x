#!/bin/bash
function str(){
  cat "$1" | sed -e 's/\t/ /g' | sed -e 's/  */ /g'
}

# run_c "$1"
function runner(){
  args=("$@")
  args=${args[@]:1}

  if [[ $1 == *.c ]]; then
    str "$1" | gcc -w -x c -;
  elif [[ $1 == *.rs ]]; then
    str "$1" | rustc -o tmp -;
  elif [[ $1 == *.f90 ]]; then
    str "$1" | gfortran -ffree-form -x f95 -o tmp -;
  # execute directly
  elif [[ $1 == *.go ]]; then
    go run "$1" $args
  elif [[ $1 == *.js ]]; then
    node "$1" $args
  elif [[ $1 == *.py ]]; then
    python3 "$1" $args
  elif [[ $1 == *.sh ]]; then
    sh "$1" $args
  elif [[ $1 == *.ts ]]; then
    # check if /bin/bun exist
    if !command -v bun &> /dev/null
    then
      # this means no bun so try tsc
      if !command -v tsc &> /dev/null
      then
        echo "tsc or bun not found"
        exit 1
      else
        tsc "$1"
        node "${1%.*}.js" $args
        exit 1
      fi
    fi
    bun "$1" $args
  # exec string
  elif [[ $1 == *.php ]]; then
    string=$(str "$1")
    php -r "$string" $args
  else
    echo "Language not supported yet"
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