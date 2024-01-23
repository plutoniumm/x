// calculates Gamma function
package main

import (
	"fmt"
)

func gamma(x float64) float64 {
	if x < 0 {
		return 0
	}
	if x == 1 {
		return 1
	}
	if x < 1 {
		// https://math.stackexchange.com/questions/1987599/approximation-of-the-gamma-function-for-small-value
		// Γ(u)=\frac 1 {2u}\left(1-𝛾  u+\frac{1}{12} \left(6 𝛾 ^2+\pi ^2\right) u^2+\frac{12𝛾+(\pi^2-6𝛾^2)u}{12𝛾+(\pi^2+6𝛾^2)u} \right)\tag 3

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
	num := 1.5
	fmt.Println(gamma(num))
}