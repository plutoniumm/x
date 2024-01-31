// calculates Gamma function
package main

import (
	"fmt"
	"os"
	"strconv"
)

func gamma(x float64) float64 {
	if x < 0 {
		return gamma(x + 1) / x
	}
	if x == 0 {
		return 1
	}
	if x < 1 {
		// https://math.stackexchange.com/questions/1987599/approximation-of-the-gamma-function-for-small-value

		// consts
		g := 0.5772156649
		gg := g * g
		uu := x * x
		pi2 := 3.1415926535 * 3.1415926535

		// composite parts
		inv := 1 / (2*x)

		Gamma := 1 - g*x + ((6*gg + pi2) * uu / 12)
		Gamma = Gamma + (12*g + (pi2 - 6*gg) * x) / (12*g + (pi2 + 6*gg) * x)
		Gamma = inv * Gamma

		return Gamma
	}
	return (x - 1) * gamma(x - 1)
}

func main(){
	// num := 1.5
	// take num from args
	args := os.Args[1:]
	num, err := strconv.ParseFloat(args[0], 64)
	if err != nil {
		fmt.Println(err)
		os.Exit(2)
	}

	fmt.Println(gamma(num))
}