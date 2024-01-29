def binary_search_iters(target: Double, rng_min: Double, rng_max: Double): Int = {
  var low = rng_min
  var high = rng_max
  var eps = 1e-32
  var iters = 0

  while (high - low > eps) {
    val mid = (low + high) / 2

    if (mid < target) {
      low = mid
    } else {
      high = mid
    }

    if (Math.abs(target - mid) < eps) {
      return iters
    } else {
      iters += 1
    }
  }
  return iters
}

@main def run(args: String*): Unit =
  val target = args(0).toDouble
  if (args.length == 0) {
    println("No arguments provided")
    return
  }
  if (target < 0 || target > 1) {
    println("Argument must be between 0 and 1")
    return
  }

  val iters = binary_search_iters(target, 0, 1)
  println(iters)