#!/usr/bin/env io

m := message(a)
m 
doMessage(m) println

exit

Object macro := method(
  args := call message arguments 
  body := args pop
  body println
  args println
  method(
    msg := call message
    args := msg arguments
    args println
    
    msg setName
  )
) 

m := macro(a, b, c,
  a + (b * (1 + c))
)

m := method(
  formalArgs := list(message(a), message(b), message(c))
  body := message(a + (b * (1 + c)))
  msg := call message
  args := msg arguments
  traverse := method(msg, formalArgs, args,
    formalArgs foreach(i, a, 
      if(msg name == a,
        msg setName
      )
    )
  )
  traverse(body, formalArgs, args)
)

x := 1
m(x, 2, 3)

exit

N := 10*1000

Date secondsToRun(
  a := 0
  b := 0
  N repeat(
    a = a + 1
    m(1, a, b) # => 1 + a + b
    m(a, 2, b)
    m(a, b, 3)
  )
) println