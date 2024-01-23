use std::time::{SystemTime, UNIX_EPOCH};

const LOOPS: i16 = 4;

fn elliptic(a: f64, b: f64, x: f64) -> f64 {
  // y^2 = x^3 + ax + b
  let mut y = (x.powf(3.0) + a * x + b).sqrt();
  // for n-1 loops with y as input to y
  for _ in 0..LOOPS {
    y = (y.powf(3.0) + a * y + b).sqrt();
  }

  return y;
}

fn main() {
  let start = SystemTime::now();
  let since_the_epoch = start.duration_since(UNIX_EPOCH).expect("Time went backwards");

  let ms = since_the_epoch.as_secs() as f64 + since_the_epoch.subsec_nanos() as f64 / 1_000_000_000.0;

  let product = ms.cos() * ms.sin();

  // a,b,base from some digit
  let a = ((product * 10123.0) % 10.0).floor().abs();
  let b = ((product * 101234.0) % 10.0).floor().abs();
  let base = ((product * 1012345.0) % 10.0).floor().abs();

  let rand = elliptic(a, b, base);
  let rand: i16 = (rand % (2.0_f64).powf(32.0)) as i16;

  println!("rand: {}", rand);
}