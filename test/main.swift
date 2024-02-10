func isMandel(_ input: Float) -> Bool {
    let MAX = 1000
    var z = (0.0, 0.0)
    let c = (-1.0, Double(input))

    for _ in 0..<MAX {
        let newZ = (z.0 * z.0 - z.1 * z.1 + c.0, 2 * z.0 * z.1 + c.1)
        z = newZ
        if z.0 * z.0 + z.1 * z.1 > 4 {
            return false
        }
    }

    return true
}

for argument in CommandLine.arguments {
    // print
    if let input = Float(argument) {
        print((isMandel(input) ? 5 : 0))
    }
}