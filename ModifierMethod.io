#!/usr/bin/env io
# oleganza
# 
# Modifier is a method returning its receiver.
# method "modifier" generates regular method with the "self" as a last expression
# Note: if you do explicit return, you have to return self manually.

Object modifier := method(
  body := call message arguments last
  body last setNext(message(a;
    self) next)
  doMessage(message(method) setArguments(call message arguments))
)

#
# Test
#
if(isLaunchScript,
  
  Queue := List clone do(
    init := method(
      self lst := list()
    )
    push := modifier(x,
      lst append(x) # assuming append() does not return self
    )
    push2 := modifier(x, y, 
      lst append(x) append(y)
    )
  )

  q := Queue clone

  q getSlot("push") println

  ((q uniqueId) == (q push(1) push2(2,3) push(4) uniqueId)) println # true

  q lst println # list(1,2,3,4)
)
