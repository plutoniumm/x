import 'dart:math';

// FUNCTIONS
double yd(double x0, v, a, t) {
  return x0 + v * t + 0.5 * a * t * t;
}

double polate(double a, b, t) {
  return a + (b - a) * t;
}

// VARIABLE CONSTANTS
double g(h) {
  double R = 6371 * 1000;
  return 9.80665 * (1 - h / R);
}

double Cd(double v) {
  // https://space.stackexchange.com/questions/12649/how-can-i-estimate-the-coefficient-of-drag-on-a-saturn-v-rocket-a-simulator-or
  double mach = v / 343;
  if (mach < 0.5) {
    return 0.27;
  } else if (mach < 1.5) {
    return polate(0.25, 0.55, mach);
  } else if (mach < 4) {
    return polate(0.55, 0.22, mach);
  } else {
    return polate(0.22, 0.25, mach);
  }
}

double rho(double y) {
  // https://en.wikipedia.org/wiki/Density_of_air#Exponential_approximation
  double Hn = 10.4 * 1000;
  double p0 = 1.225;
  return p0 * exp(-y / Hn);
}

double Fd(double A, v, y) {
  return 0.5 * Cd(v) * A * rho(y) * v * v;
}

// dynamics
double a(thrust, y, v, m, area) {
  double F = thrust - Fd(area, v, y) - m * g(y);
  return F / m;
}

double mt(m, t, r) {
  //  rate of fuel consumption
  return m - t * r;
}

String trim(num z) {
  return (z / 1000).toStringAsFixed(2);
}

// SaturnV
void log(var x, v, a) {
  x = (x / 1000).toStringAsFixed(2);
  v = (v / 1000).toStringAsFixed(2);
  a = (a / 1000).toStringAsFixed(2);
  print('x: $x km, v: $v km/s, a: $a km/s^2');
}

var SaturnV = {
  'gross': [2214, 496.2, 123],
  'empty': [137, 40.1, 15.5],
  'section': [10.1, 10.1, 6.6],
  'burns': [168, 360, 165 + 335],
  'thrusts': [6770 * 5, 5141 * 5, 1033 * 1]
};

var LongMarch5 = {
  'gross': [186.9, 36],
  'empty': [21.6, 6.9],
  'section': [5, 5],
  'burns': [492, 700],
  'thrusts': [1036 * 2, 176.72 * 2]
};

// var Rockets = {'SaturnV': SaturnV, 'LongMarch5': LongMarch5};
var Rockets = [SaturnV, LongMarch5];

void main(List<String> args) {
  if (args.length == 0) {
    print('Usage: dart main.dart <int>');
    return;
  }
  var index = int.parse(args[0]);
  index = index % Rockets.length;

  var ROCKET = Rockets[index];
  // main
  var m_empty = ROCKET['empty'];
  var m_gross = ROCKET['gross'];
  var section = ROCKET['section'];

  var thrusts = ROCKET['thrusts'];
  var burn_t = ROCKET['burns'];

  if (m_empty == null ||
      m_gross == null ||
      section == null ||
      thrusts == null ||
      burn_t == null) {
    print('Invalid rocket');
    return;
  }

  thrusts = thrusts.map((e) => 1000 * e).toList();
  m_gross = m_gross.map((e) => 1000 * e).toList();
  m_empty = m_empty.map((e) => 1000 * e).toList();
  section = section.map((e) => pow(e / 2, 2)).toList();

  // for each stage, while dt
  var m = m_gross.reduce((a, b) => a + b);
  var dt = 0.01;
  var y = 0.0;
  var v = 0.0;
  for (var i = 0; i < section.length; i++) {
    var t = 0.0;
    var m0 = m_empty[i];
    var m1 = m_gross[i];
    var t1 = burn_t[i];
    var r = (m1 - m0) / t1;

    while (t < t1) {
      var a0 = a(thrusts[i], y, v, m, section[i]);
      var y1 = yd(y, v, a0, dt);
      var m1 = mt(m, dt, r);
      var v1 = v + a0 * dt;
      t += dt;
      y = y1;
      m = m1;
      v = v1;
    }
    m = m - m0 + 0.1;
    // print('Stage ${i + 1} burnout');
    // print('m: ${trim(m)} kg, y: ${trim(y)} km, v: ${trim(v)} km/s');
  }
  print(trim(v));
}
