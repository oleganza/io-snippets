#!/usr/bin/env io
# oleganza 
# July, 1 2008

Module := Object clone do(
  Object := method(self)
)

A := Module clone do(
  B := Object clone do(
    c := method(C)
  )
  C := Object clone do(
    b := method(B)
  )
)

if(isLaunchScript,
  (A B c == A C) println
  (A C b == A B) println
)
