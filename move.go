package main

import "fmt"
func move(m int ,n int ,p int ,q int) int{
  var dis1,dis2,num int
if (m==0 && n==0)||(m==0 && n==4)||(m==4 && n==0)||(m==4 && n==4){
num = 3
} else if (m==0 || n==0 || m==4 || n==4){
    num = 5
} else {
    num = 8
    }
  dis1 = m-p
  if dis1<0 {
      dis1 =-1*dis1
    }
  dis2 = n-q
  if dis2<0 {
      dis2 =-1*dis2 }
  if (dis1+dis2)<=2 {
      num--
    }
    return(num)

      
  }


func main() {

    // Create two-dimensional array.
    letters := [5][5]string{
    }

    letters[0][0] = "a"
    letters[0][1] = "b"
    letters[0][2] = "c"
    letters[0][3] = "d"
    letters[0][4] = "e"
    letters[1][0] = "f"
    letters[1][1] = "g"
    letters[1][2] = "h"
    letters[1][3] = "i"
    letters[1][4] = "j"
    letters[2][0] = "k"
    letters[2][1] = "l"
    letters[2][2] = "m"
    letters[2][3] = "n"
    letters[2][4] = "o"
    letters[3][0] = "p"
    letters[3][1] = "q"
    letters[3][2] = "r"
    letters[3][3] = "s"
    letters[3][4] = "t"
    letters[4][0] = "u"
    letters[4][1] = "v"
    letters[4][2] = "w"
    letters[4][3] = "x"
    letters[4][4] = "y"
    var m,n,p,q int
    for i:=0;i<4;i++{
    fmt.Println("enter the ROW of letter to be move")

    fmt.Scanln(&m)
    fmt.Println("enter the COLOUMN of letter to be move")
    fmt.Scanln(&n)
    fmt.Println("enter the ROW of letter which is blocked")
    fmt.Scanln(&p)
    fmt.Println("enter the COLOUMN of letter which is blocked")
    fmt.Scanln(&q)
    var res int
    res = move(m,n,p,q)
    fmt.Println("moves")
    fmt.Println(res,"\n")

  }
}
