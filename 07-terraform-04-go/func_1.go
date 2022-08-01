package main
import "fmt"

func main() {
	fmt.Print("Enter metres: ")
	var input float64
	var koef float64 = 1 / 0.3048
	fmt.Scanf("%f", &input)
	output := input * koef
	fmt.Println(input, "metres is", output, "foots")
}