package main
import "fmt"

func leastNumber(ar[]int) int {
    var answ int = 0
    for i := 0; i < len(ar)-1; i++ {
        if answ > ar[i] || i == 0 {
            answ = ar[i]
        }
    }
    return answ
}

func main() {
    x := []int{48,96,86,68,57,82,63,70,37,34,83,27,19,97,9,17,}
    var answ = leastNumber(x)
    fmt.Println(answ)
}