package main
import "fmt"
type College struct {
    class string
    student
}

type student struct {
    dept string
    year    string
}

func main() {

    c := &College{
        class: "mech",
        student: student{
            dept: "mech",
            year:    "second",
        },
    }
    fmt.Println(c)
}
