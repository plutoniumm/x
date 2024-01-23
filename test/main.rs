const LOOPS: i16 = 4;

// y^2 = x^3 + ax + b
fn elliptic(a: f64, b: f64, x: f64) -> f64 {
  let mut y = (x.powf(3.0) + a * x + b).sqrt();
  for _ in 0..LOOPS {
    y = (y.powf(3.0) + a * y + b).sqrt();
  }

  return y;
}

fn main() {
  // unwrap will panic if there is no argument :)
  let ms = std::env::args().nth(1).unwrap().parse::<f64>().unwrap();

  let product = ms.cos() * ms.sin();

  let a = ((product * 10123.0) % 10.0).floor().abs();
  let b = ((product * 101234.0) % 10.0).floor().abs();
  let base = ((product * 1012345.0) % 10.0).floor().abs();

  let rand = elliptic(a, b, base);
  let rand = (rand % (2.0_f64).powf(16.0)) as i16;

  println!("{}", rand);
}