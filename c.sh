#!/bin/bash
function run_c(){
  string=$(cat "$1" | sed -e 's/\t/ /g' | sed -e 's/  */ /g')

  echo "$string" | gcc -w -x c -;
  if [ -f "a.out" ]; then
    ./a.out
    rm a.out
  fi
}

function run_rust(){
  string=$(cat "$1" | sed -e 's/\t/ /g' | sed -e 's/  */ /g')

  echo "$string" | rustc -;
  if [ -f "a.out" ]; then
    ./a.out
    rm a.out
  fi
}

function run_go(){
  string=$(cat "$1" | sed -e 's/\t/ /g' | sed -e 's/  */ /g')

  echo "$string" | go run -;
}

# run_c "$1"
function runner(){
  if [[ $1 == *.c ]]; then
    run_c "$1"
  elif [[ $1 == *.rs ]]; then
    run_rust "$1"
  elif [[ $1 == *.go ]]; then
    run_go "$1"
  else
    echo "Language not supported yet"
    exit 1
  fi
}

runner "$1"