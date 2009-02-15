#!/usr/bin/env io

a := method(1)

m := method(a, b, c,
  (a + b) * c
)



(getSlot("m") )println
(carry(m(1)) ) println