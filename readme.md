# x
`x random.lang args`

I recommend typing gcc over and over and over again if you commonly use 2-3-4 maybe even 5 languages. If you COMMONLY write scripts in like 15 languages (which i dont get why), then this is for you, otherwise generally it's for fun.

## Using
Literally just curl it into local bin
```bash
curl https://raw.githubusercontent.com/plutoniumm/x/master/x > /usr/local/bin/x
```

Use normally as `x file <args?>`, it should support most languages with args and piping. so `x add.c 1 2 | x fib.rb 3` should work normally for some file `add.c` which takes `int,int` and `fib.rb` which takes `int,int` where output of add.c is piped into fib.rb as 2nd arg.

<!-- ## Ideas
- Solve some specific navier stokes eq
- Solve some specific general relativity case
- Something with the 3-body problem
- Calc e
- Calc euler-mascheroni constant
- Omega constant by iterating over Oe^O = 1 -->

## Notes
- Perl: Idk if this is needed
- R: Very very crappy tooling
- Lisp: Also same

## Tests

| Lang (.ext)        | Types         | Desc                                     |
|--------------------|---------------|------------------------------------------|
| c (`.c`)           | `void→int`    | 1 if stack increases else -1             |
| Ruby (`.rb`)       | `int→int`     | Floor(abs(cos $n + sin $n))              |
| Javascript (`.js`) | `int→int`     | 3x3 Gaussian blur w/ 1,1=$n              |
| Typescript (`.ts`) | `int→int`     | 3x3 Gaussian blur w/ i,j=i+j &amp; 1,1=$n|
| Haskell (`.hs`)    | `int→float`    | Schwarzschild rad for for $n sols        |
| Rust (`.rs`)       | `float→float`   | Elliptic curve value from seed $n        |
| PHP (`.ph`)        | `float→float`   | Entropy of string  $n                    |
| Go (`.go`)         | `float→float`   | approx Gamma function for $n             |
| Scala (`.sc`)      | `float→int`    | #iters to binary search $n $\in [0,1]$   |
| Lua (`.lua`)       | `int→int`     | Convert $n to base 7                     |
| Fortran (`.f90`)   | `int→int`     | Miller-Rabin primality test for $n       |
| Python (`.py`)     | `int→float`    | Calculate energy for QHM at $n'th        |
| OCaml (`.ml`)      | `float→float`   | Golden ratio of fib series from seed $n   |
| Kotlin (`.kt`)     | `float→int`    | 10th Fibonacci num from $phi             |
| C++ (`.cpp`)       | `int→float`    | Value of pi est for circ of radius $n    |
| Elixir (`.exs`)    | `float→float`   | Calc Entropy in milli eV of $n           |
| Swift (`.swift`)   | `float→int`    | Check if -1 + i($n)  is Mandelbrot       |
| Java (`.java`)     | `int→float`    | Calc Gauss const via AGM for $n iters    |
| Julia (`.jl`)      | `float→float`   | Angle in deg for 1 + i($n)               |
| Cobol (`.cob`)     | `float→float`   | Escape vel for planet $n * Earth mass    |
|OSA (`.applescript`)| `float→float`   | Benford Probabaility of $n 1st char      |
