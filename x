#!/bin/bash
function str(){
  cat "$1" | sed -e 's/\t/ /g' | sed -e 's/  */ /g'
}

languages=("c" "cpp" "rs" "f90" "cob" "py" "sh" "java" "php" "rb" "kt" "go" "swift" "lua" "sc" "ml" "scpt" "applescript" "exs" "jl" "m" "r" "groovy" "mojo" "dart" "zig" "mojo" "lisp")
# some langs have custom checks which are ignored here
deps=("g++" "gcc" "rustc" "gfortran" "cobc" "python3" "bash" "java" "php" "ruby" "kotlinc" "go" "swift" "lua" "scala" "ocaml" "osascript" "elixir" "julia" "octave" "rscript" "groovy" "mojo" "dart" "zig" "mojo" "emacs")

function exists(){
  if command -v "$1" &> /dev/null; then
    echo "true"
  else
    echo "false"
  fi
}

# wrapper on exists, but exit if false and print error
function enforce(){
  if [ "$(exists "$1")" == "false" ]; then
    echo "$1 not found, please install it or add it to PATH";
    exit 1;
  fi
}

function autoexec(){
  if [ -f package.json ]; then
    if grep -q '"dev":' package.json; then
      npm run dev;
      exit 0;
    elif grep -q '"start":' package.json; then
      npm start;
      exit 0;
    fi
  elif [ -f makefile ]; then
    make;
    exit 0;
  elif [ -f go.mod ]; then
    go run *.go;
    exit 0;
  fi
}

function runner(){
  args=("$@")
  if [ ! -f "$1" ]; then
    if [ -z "$1" ]; then
      echo "No file, running autoexec";
      autoexec;
      exit 0;
    fi

    echo "not a file, got $1";
    exit 1;
  fi


  args=("${args[@]:1}")
  rcv_stdin=""
  if [ -p /dev/stdin ]; then
    rcv_stdin=$(cat -)
    args+=("$rcv_stdin")
  fi

  # check if language deps are installed
  for lang in "${languages[@]}"; do
    if [[ $1 == *.$lang ]]; then
      enforce "${deps[$i]}"
    fi
  done

  if [[ $1 == *.cpp ]]; then
    g++ -w -x c++ "$1" -o tmp;
  elif [[ $1 == *.c ]]; then
    gcc -w -x c "$1" -o tmp;
  elif [[ $1 == *.rs ]]; then
    rustc "$1" -o tmp;
  elif [[ $1 == *.f90 ]]; then
    gfortran -ffree-form -x f95 "$1" -o tmp;
  elif [[ $1 == *.cob ]]; then
    cobc -x -free $1 -o a.out;
  elif [[ $1 == *.js ]]; then
    node "$1" "${args[@]}";
  elif [[ $1 == *.py ]]; then
    python3 "$1" "${args[@]}";
  elif [[ $1 == *.mojo ]]; then
    mojo "$1" "${args[@]}";
  elif [[ $1 == *.sh ]]; then
    bash "$1" "${args[@]}";
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
  elif [[ $1 == *.java ]]; then
    javac "$1";
    java "${1%.*}" "${args[@]}";
    rm "${1%.*}.class";
  elif [[ $1 == *.php ]]; then
    php "$1" "${args[@]}";
  elif [[ $1 == *.rb ]]; then
    ruby "$1" "${args[@]}";
  elif [[ $1 == *.kt ]]; then
    kotlinc "$1" -include-runtime -d tmp.jar
    java -jar tmp.jar "${args[@]}";
    rm tmp.jar;
  elif [[ $1 == *.go ]]; then
    go run "$1" "${args[@]}";
  elif [[ $1 == *.swift ]]; then
    swift "$1" "${args[@]}";
  elif [[ $1 == *.dart ]]; then
    dart run "$1" "${args[@]}";
  elif [[ $1 == *.lua ]]; then
    lua "$1" "${args[@]}";
  elif [[ $1 == *.r ]]; then
    Rscript "$1" "${args[@]}";
  elif [[ $1 == *.m ]]; then
    octave "$1" "${args[@]}";
  elif [[ $1 == *.lisp ]]; then
    emacs --batch --eval "$(cat "$1")" "${args[@]}";
  elif [[ $1 == *.sc ]]; then
    scala "$1" "${args[@]}";
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
  elif [[ $1 == *.ml ]]; then
    ocaml "$1" "${args[@]}";
  elif [[ $1 == *.scpt ]]; then
    osascript "$1" "${args[@]}";
  elif [[ $1 == *.applescript ]]; then
    osascript "$1" "${args[@]}";
  elif [[ $1 == *.exs ]]; then
    elixir "$1" "${args[@]}";
    rm "${1%.*}.beam";
  elif [[ $1 == *.jl ]]; then
    julia "$1" "${args[@]}";
  elif [[ $1 == *.zig ]]; then
    zig run "$1" -- "${args[@]}";
  else
    # check if no extension
    if [[ $1 == *.* ]]; then
      echo "not supported, got $1";
      exit 1;
    fi

    # check if has shebang
    if [ -x "$1" ]; then
      ./"$1" "${args[@]}";
      exit 0;
    else
      echo "not supported, got $1";
      exit 1;
    fi
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

runner "$1" "${@:2}";