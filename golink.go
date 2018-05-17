package main
import "fmt"
type item struct {
  nextp *item
  val int
}
func create() *item {
  headp := &item{nil,1}
  currp := headp
  for i:= 2 ;i<10;i++{
    itemp := &item{nil,i}
    currp.nextp = itemp
    currp = itemp
  }
  return headp
  }
func print(listp *item){
  currp:= listp
  for {
    fmt.Println("%c",currp.val)
    if currp.nextp != nil{
      currp = currp.nextp
    }else {
      break
    }

  }
  fmt.Println(" ")
    }
    func revearse(listp *item) *item  {
      currp := listp
      var topp *item = nil
      for {
        if currp == nil {
          break
          }
          tempp := currp.nextp
          currp.nextp = topp
          topp = currp
          currp = tempp

      }
      return topp
    }
    func main(){
      var listp = create()
      print(listp)
      print(revearse(listp))
    }
