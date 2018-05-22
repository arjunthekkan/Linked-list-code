package main
import "fmt"

type person struct {
    name string
    age  int
}
func main() {
fmt.Println(person{name: "Alice", age: 30})
fmt.Println(person{name: "Ann", age: 40})

}
