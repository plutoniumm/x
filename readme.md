## Using
Literally just curl it into local bin
```bash
curl https://raw.githubusercontent.com/plutoniumm/x/master/x > /usr/local/bin/x
```

Use normally as `x file <args?>`, it should support most languages with args and piping. so `x add.c 1 2 | x fib.rb 3` should work normally for some file `add.c` which takes `int,int` and `fib.rb` which takes `int,int` where output of add.c is piped into fib.rb as 2nd arg.

## Tests

| Lang (.ext)        | Types                 | Desc                                     |
|--------------------|-----------------------|------------------------------------------|
| c (`.c`)           | `void`&rarr;`int`     | 1 if stack increases else -1             |
| Ruby (`.rb`)       | `int`&rarr;`int`      | Floor(abs(cos x + sin x))                |
| Javascript (`.js`) | `int`&rarr;`int`      | 3x3 Gaussian blur w/ 1,1=n               |
| Typescript (`.ts`) | `int`&rarr;`int`      | 3x3 Gaussian blur w/ i,j=i+j &amp; 1,1=n |
| Haskell (`.hs`)    | `int`&rarr;`float`    | Schwarzschild rad for for n sols         |
| Rust (`.rs`)       | `float`&rarr;`float`  | Elliptic curve value from seed           |
| PHP (`.ph`)        | `string`&rarr;`float` | Entropy of string                        |
| Gi (`.gi`)         | `float`&rarr;`float`  | approx Gamma function                    |
| Scala (`.sc`)      | `float`&rarr;`int`    | #iters to binary search num $\in [0,1]$  |
| Fortran (`.f9`)    | `int`&rarr;`string`   | Convert to base 7                        |
| Python (`.py`)     | `int`&rarr;`float`    | Calculate energy for QHM at nth level    |
| OCaml (`.ml`)      | `float`&rarr;`float`  | Golden ratio from fib series from seed   |