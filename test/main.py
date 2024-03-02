from sys import argv


sqrt = lambda x: x**0.5
exp = lambda x: 2.7182818284**x
pi = 3.141592535


x = 7.4e-11  # hydrogen atom radius
h = 6.62607004e-34
hc = h / (2 * pi)
k = 9 * 10**9
c = 299792458
e = 1.60217662e-19
m = 9.10938356e-31
J2EV = lambda j: round(-1 * j / e, 6)


def w(n):
  v = 4 * (pi**2) * (k**2) * m * (e**4) / (h**3) * n**2
  return 2 * pi * v


alpha = lambda n: m * w(n) / hc


# solving quantum harmonic oscillator
def Hermite(n):
  if n == 0:
    return lambda _: 1
  if n == 1:
    return lambda y: 2 * y
  if n > 1:
    # since Hn+1 = 2yHn - 2nHn-1
    return lambda y: 2 * y * Hermite(n - 1)(y) - 2 * (n - 1) * Hermite(
      n - 2
    )(y)


def fact(n):
  if n == 0:
    return 1
  else:
    return n * fact(n - 1)


def psi(n):
  return (
    lambda x: (alpha(n) / pi) ** (1 / 4)
    * 1
    / sqrt(2**n * fact(n))
    * Hermite(n)((x * alpha(n) ** 0.5))
    * exp(-1 * (x * alpha(n) ** 0.5) ** 2 / 2)
  )


# twice differentiated psi
def psidd(n):
  return lambda x: psi(n)(x) * (alpha(n) ** 2 * x**2 - alpha(n))


def E(x, n):
  return J2EV(
    ((-1 * (hc**2) / (2 * m)) * psidd(n)(x) / psi(n)(x))
    + (1 / 2) * m * w(n) ** 2 * x**2
  )


if len(argv) == 1:
  print('Please enter a quantum number n (1-4)')
  exit()

n = int(argv[1])
if n < 1 or n > 4:
  print('Please enter a quantum number n (1-4)')


energy = E(x, n)
print(energy)
