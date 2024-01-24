## Returns
- `main.c`: +1 if stack increases else -1
- `main.rb`: Floor(abs(cos x + sin x)), low effort :)
- `main.js`: Gaussian filter on 3x3 with n in the middle
- `main.ts`: Gaussian filter on 3x3 with n in the middle with initial values
- `main.hs`: Calculate schwarzschild radius for `:int+:` for n solar masses
- `main.rs`: Some Elliptic curve value from `./a.out :float:`
- `main.php`: Calculate entropy of a string for `:string:`
- `main.go`: approx Gamma function for `:real+:`

- `main.py`: Calculate energy for QHM at nth level for `:[1-5]:`
- `main.f90`: "prime" or "composite" for `./a.out :int+:`

## Types
```mermaid
 C --> RB --> JS -->
TS --> HS --> RS -->
PHP --> GO
```
- `c`: void &rarr; +1/-1
- `rb`: int &rarr; int
- `js`: int &rarr; int
- `ts`: int &rarr; int
- `hs`: int &rarr; float
- `rs`: float &rarr; float
- `php`: string/float &rarr; float
- `go`: float &rarr; float

- `f90`: int &rarr; string
- `py`: int &rarr; float


## Caveats
- Gamma func is approximate since for small x it uses laurin series and then reduces error via pade's approximation

## TODO:
- Pass args into each `x file args`
- Run test in->a->b->c->...out