#!/usr/bin/env io

N := 1*1000

List mapp := method(
  msg := call message
  msg previous
  /*args := msg arguments
    if(args size == 1,
      msg replace(message())
    )*/
)

#list(N,2) mapp arguments println
#exit

#list(1,2,3) mapp(*2) println
# -> List map_123 := method(l = List clone; foreach(v, l push(v * 2) ); l )
# -> list(1,2,3) map_123

#exit

Date secondsToRun(
  N repeat(
    1 # no op
  )
) println

Date secondsToRun(
  lst := list(1, 2, 3, 4, 5)
  N repeat(
    lst map(*2)
    lst map(*2)
    lst map(x, 2 * x)
    lst map(x, 2 * x)
  )
) println 

Date secondsToRun(
  lst := list(1, 2, 3, 4, 5)
  N repeat(
    l := List clone; lst foreach(v, l push(v * 2))
    l := List clone; lst foreach(v, l push(v * 2))
    l := List clone; lst foreach(x, l push(2 * x))
    l := List clone; lst foreach(x, l push(2 * x))
  )
) println 

exit

Date secondsToRun(
  lst := list(1, 2, 3, 4, 5)
  N repeat(
    lst mapp(*2)
    lst mapp(*2)
    lst mapp(x, 2 * x)
    lst mapp(x, 2 * x)
  )
) println