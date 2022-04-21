package main

import (
	"fmt"
	"math"
)

func FeetConvertor(val float64) float64 {
	// Convert in meters and round result to 2 decimal places.
	//return math.Round(val*0.3048*100) / 100
	return math.Round(val*0.3048*100) / 100
}

func FindMin(collection []int) *int {

    // We'll use pointer to distinguish situation of no values in provided collection.
    var found *int

    for _, s := range collection {
        if found == nil {
            // Initialize value.
            found = new(int)
            *found = s
        } else if s < *found {
            // Register new minimal value.
            *found = s
        }
    }

    return found
}

func ShowDevisibleBy(begin, end, devisor int) []int {
  result := []int{}
  for i := begin; i <= end; i++ {
    if i % devisor == 0 {
      result = append(result, i)
    }
  }
  return result
}

func main() {

    //////////////////////////////////////////////////////////////////////////
    // TASK 3.1
    // Welcome message.
    fmt.Print("Enter length in feet: ")

    // Receive user input.
    var input float64
    fmt.Scanf("%f", &input)

    // Print out the result.
    fmt.Println(fmt.Sprintf("In meters it's: %.2f\n", FeetConvertor(input)))

    //////////////////////////////////////////////////////////////////////////
    // TASK 3.2
    x := []int{48, 96, 86, 68, 57, 82, 63, 70, 37, 34, 83, 27, 19, 97, 9, 17}
    //x := []int{}

    min := FindMin(x)

    // If empty pointer returned then there was no any value found.
    if min == nil {
        fmt.Printf("No values found!\n")
    } else {
        fmt.Printf("The minimal value is: %d\n", *min)
    }

    //////////////////////////////////////////////////////////////////////////
    // TASK 3.3
    fmt.Print("Devisible values: ", ShowDevisibleBy(1, 10, 3), "\n")
}
