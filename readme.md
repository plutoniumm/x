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
graph LR
 C --> RB --> JS -->
TS --> HS --> RS -->
PHP --> GO
```

| Lang | In Type | Out Type |
| ---- | ------- | -------- |
| C    | void    | int      |
| RB   | int     | int      |
| JS   | int     | int      |
| TS   | int     | int      |
| HS   | int     | float    |
| RS   | float   | float    |
| PHP  | string/float | float |
| GO   | float   | float    |
<!--  -->
| F90  | int     | string   |
| PY   | int     | float    |