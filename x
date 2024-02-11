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

function runner(){
  args=("$@")
  args=("${args[@]:1}")
  rcv_stdin=""
  if [ -p /dev/stdin ]; then
    rcv_stdin=$(cat -)
    args+=("$rcv_stdin")
  fi

  # stream to compiler
  if [[ $1 == *.c ]]; then
    str "$1" | gcc -w -x c -;
  elif [[ $1 == *.cpp ]]; then
    str "$1" | g++ -w -x c++ -;
  elif [[ $1 == *.rs ]]; then
    str "$1" | rustc -o tmp -;
  elif [[ $1 == *.f90 ]]; then
    str "$1" | gfortran -ffree-form -x f95 -o tmp -;
  elif [[ $1 == *.cob ]]; then
    cobc -x -free main.cob -o a.out;
  # execute directly
  elif [[ $1 == *.scpt ]]; then
    osascript "$1" "${args[@]}";
  elif [[ $1 == *.applescript ]]; then
    osascript "$1" "${args[@]}";
  elif [[ $1 == *.swift ]]; then
    swift "$1" "${args[@]}";
  elif [[ $1 == *.exs ]]; then
    elixir "$1" "${args[@]}";
    rm "${1%.*}.beam";
  elif [[ $1 == *.rb ]]; then
    ruby "$1" "${args[@]}";
  elif [[ $1 == *.lua ]]; then
    lua "$1" "${args[@]}";
  elif [[ $1 == *.sc ]]; then
    scala "$1" "${args[@]}";
  elif [[ $1 == *.java ]]; then
    javac "$1";
    java "${1%.*}" "${args[@]}";
    rm "${1%.*}.class";
  elif [[ $1 == *.kt ]]; then
    kotlinc "$1" -include-runtime -d tmp.jar
    java -jar tmp.jar "${args[@]}";
    rm tmp.jar;
  elif [[ $1 == *.go ]]; then
    go run "$1" "${args[@]}";
  elif [[ $1 == *.ml ]]; then
    ocaml "$1" "${args[@]}";
  elif [[ $1 == *.hs ]]; then
    # check if ghc
    has_ghc=$(exists ghc)
    has_stack=$(exists stack)
    # if neither then error
    if [ "$has_ghc" == "false" ] && [ "$has_stack" == "false" ]; then
      echo "ghc or stack not found";
      exit 1;
    fi
    # if ghc then use ghc
    if [ "$has_ghc" == "true" ]; then
      ghc "$1" "${args[@]}";
    else
      stack runghc "$1" "${args[@]}";
    fi
  elif [[ $1 == *.js ]]; then
    node "$1" "${args[@]}";
  elif [[ $1 == *.py ]]; then
    python3 "$1" "${args[@]}";
  elif [[ $1 == *.ts ]]; then
    has_bun=$(exists bun)
    has_tsc=$(exists tsc)
    # if neither then error
    if [ "$has_bun" == "false" ] && [ "$has_tsc" == "false" ]; then
      echo "bun or tsc not found";
      exit 1;
    fi
    if [ "$has_bun" == "true" ]; then
      bun "$1" "${args[@]}";
    else
      tsc "$1";
      node "${1%.*}.js" "${args[@]}";
      rm "${1%.*}.js";
    fi
  elif [[ $1 == *.php ]]; then
    php "$1" "${args[@]}";
  else
    echo "not supported, got $1";
    exit 1;
  fi

  # execute
  if [ -f tmp ]; then
    ./tmp "${args[@]}";
    rm tmp;
  elif [ -f a.out ]; then
    ./a.out "${args[@]}";
    rm a.out;
  fi
}

runner "$1" "${@:2}"