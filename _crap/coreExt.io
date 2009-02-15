#!/usr/bin/env io

Number times := method( 
  s := call argAt(0) asString
  a := 0
  while(a < self, 
    call sender setSlot(s, a)
    call evalArgAt(1)
    a = a + 1
  )
)

5 times(i, i println) 
i println