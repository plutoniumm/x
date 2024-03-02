import java.lang.Math

def stdv(double n) {
    double u = -1 * n
    double del = 0.0001
    double sum = 0
    while(u < n) {
        double expo1 = -1 * Math.pow(u, 2) / 2
        double sdv1 = Math.exp(expo1)
        sum += sdv1 * del

        u = u + del
    }
    sum /= (Math.sqrt(2 * Math.PI))
    sum *= 100
    return sum
}

def n = args.length > 0 ? args[0].toDouble() : 5 // default to 5
def devs = stdv(n)

println "$devs"