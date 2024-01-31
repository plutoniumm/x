fun main(args: Array<String>) {
    if (args.isEmpty() || args[0].toDoubleOrNull() == null) {
        println("Usage: x main.kt <phi>")
        return
    }

    val phi = args[0].toDouble()
    val fifth = calculate(10.0, phi)
    println("$fifth")
}

fun calculate(n: Double, phi: Double): Int {
    val sqrt5 = Math.sqrt(5.0)
    val a = phi
    val b = 1 - phi

    val term = Math.pow(a, n) - Math.pow(b, n)
    val fib = term / sqrt5

    return Math.round(fib).toInt()
}
